//
//  GameListController.swift
//  GameCatalogueDicoding
//
//  Created by Kalfian on 01/08/20.
//  Copyright © 2020 Kalfian. All rights reserved.
//

import UIKit
import MBProgressHUD
import PaginatedTableView

class GameListController: UIViewController {

    @IBOutlet weak var gameTableView: PaginatedTableView!
    
    //MARK:- Variables
    private var games: [Game] = []
    private var query: String = ""
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.title = "Game List"
        
        setTableView()
//        settingSearchBar()
        gameTableView.tableFooterView = UIView()
        setupSearchBar()
        
    }
    
    //MARK:- Get Game DB Interaction
    
    fileprivate func getGame(query: String, page: Int, completionHandler: @escaping(_ games: GameResponse?,_ err: Error?) -> Void) {
        GameServiceApi.shared.fetchMovies(page: page, query: query, from: .list) { (result: Result<GameResponse, GameServiceApi.APIServiceError>) in

            switch result {
                case .success(let gameResponse):
                    completionHandler(gameResponse, nil)
                case .failure(let error):
                    completionHandler(nil, error)
            }
        }
    }

}

//MARK:- Setting UITableView
extension GameListController: PaginatedTableViewDelegate, PaginatedTableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func loadMore(_ pageNumber: Int, _ pageSize: Int, onSuccess: ((Bool) -> Void)?, onError: ((Error) -> Void)?) {
        var gamesContent: GameResponse?
        
        getGame(query: query, page: pageNumber) { (games, error) in
            
            gamesContent = games
            
            DispatchQueue.main.sync {
                if error != nil {
                    onError?(error!)
                }
                
                if gamesContent?.next != nil {
                    onSuccess?(true)
                } else {
                    onSuccess?(false)
                }
                
                if pageNumber == 1 { self.games = [] }
                
                guard let game = gamesContent else {
                    return
                }
                
                self.games.append(contentsOf: game.results)
                
                self.gameTableView.reloadData()
            }
        }
        
    }
    
    
    func setTableView() {
        self.gameTableView.paginatedDelegate = self
        self.gameTableView.paginatedDataSource = self
        
        self.gameTableView.register(UINib(nibName: Constant.Nib.LIST_GAME_CELL, bundle: nil), forCellReuseIdentifier: Constant.Nib.LIST_GAME_IDENTIFIER)
        
        self.gameTableView.rowHeight = UITableView.automaticDimension
        self.gameTableView.estimatedRowHeight = 180
        
        self.gameTableView.loadData(refresh: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if games.count == 0 {
            tableView.setEmptyView(title: "Data Kosong", message: "Silahkan melakukan pencarian lain")
        } else {
            tableView.restore(separator: .none)
        }
        
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let gameCell = tableView.dequeueReusableCell(withIdentifier: Constant.Nib.LIST_GAME_IDENTIFIER, for: indexPath) as? ListGameCell else {
            fatalError("The dequeued cell is not an instance of TableViewCell.")
        }
        
        let row = indexPath.row
        gameCell.gameTitle.text = self.games[row].name
        let image = self.games[row].backgroundImage
        gameCell.gameImage.loadImage(url: image)
        
        
        return gameCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !(indexPath.row > games.count) {
            
            // To Detail Game
            performSegue(withIdentifier: Constant.Segue.DETAIL_GAME, sender: indexPath.row)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.Segue.DETAIL_GAME {
            guard let targetController = segue.destination as? GameDetailController else { return }
            
            let indexRow = sender as? Int
            targetController.id = games[indexRow ?? 0].id
            targetController.gameTitle = games[indexRow ?? 0].name
        }
    }
    
}

//MARK:- Setting Searchbar

extension GameListController: UISearchBarDelegate {
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search game"
        searchController.obscuresBackgroundDuringPresentation = false
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.games = []
        self.query = searchBar.text ?? ""
        self.gameTableView.setContentOffset(.zero, animated: true)
        self.gameTableView.loadData(refresh: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.games = []
        self.query = ""
        self.gameTableView.setContentOffset(.zero, animated: true)
        self.gameTableView.loadData(refresh: true)
        
    }
    
}

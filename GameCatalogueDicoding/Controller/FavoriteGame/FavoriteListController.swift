//
//  FavoriteListController.swift
//  GameCatalogueDicoding
//
//  Created by Kalfian on 15/08/20.
//  Copyright © 2020 Kalfian. All rights reserved.
//

import UIKit

class FavoriteListController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    //MARK:- Variables
    private var games: [GameObj] = []
    private var gamesFiltered: [GameObj] = []
    
    private var query: String = ""
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getAllData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        
        favoriteTableView.tableFooterView = UIView()
        setupSearchBar()
    }

}

extension FavoriteListController: UITableViewDelegate, UITableViewDataSource {
    
    func getAllData() {
        self.games = GameServiceDB.shared.getData()
        self.gamesFiltered = games
        
        let searchText = searchController.searchBar.text ?? ""
        guard  !searchText.isEmpty else {
            self.games = gamesFiltered
            favoriteTableView.reloadData()
            return
        }
        
        self.games = gamesFiltered.filter({ (data) -> Bool in
            return data.name.lowercased().contains(searchText.lowercased())
        })
        
        favoriteTableView.reloadData()
    }
    
    func setTableView() {
        self.favoriteTableView.delegate = self
        self.favoriteTableView.dataSource = self
        
        self.favoriteTableView.register(UINib(nibName: Constant.Nib.listGameCell, bundle: nil), forCellReuseIdentifier: Constant.Nib.listGameIdentifier)
        
        self.favoriteTableView.rowHeight = UITableView.automaticDimension
        self.favoriteTableView.estimatedRowHeight = 180
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if games.count == 0 {
            tableView.setEmptyView(title: "Data Kosong", message: "Belum ada data yang dimasukkan sebagai favorit")
        } else {
            tableView.restore(separator: .none)
        }
        
        return self.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let gameCell = tableView.dequeueReusableCell(withIdentifier: Constant.Nib.listGameIdentifier, for: indexPath) as? ListGameCell else {
            fatalError("The dequeued cell is not an instance of TableViewCell.")
        }
        
        let row = indexPath.row
        if !(indexPath.row > games.count) {
            gameCell.gameTitle.text = self.games[row].name
            let image = self.games[row].backgroundImage
            gameCell.gameImage.loadImage(url: image)
            gameCell.gameRating.rating = Double(self.games[row].rating)

            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "dd MMM ,yyyy"

            gameCell.gameRelease.text = "Released date: "+dateFormatterPrint.string(from: self.games[row].released)
        }
        
        return gameCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !(indexPath.row > games.count) {
            
            // To Detail Game
            performSegue(withIdentifier: Constant.Segue.detailGame, sender: indexPath.row)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.Segue.detailGame {
            guard let targetController = segue.destination as? GameDetailController else { return }
            
            let indexRow = sender as? Int
            targetController.id = games[indexRow ?? 0].id
            targetController.gameTitle = games[indexRow ?? 0].name
            targetController.isFavorite = true
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "dd MMM ,yyyy"
            
            targetController.gameRelease = "Released date: " + dateFormatterPrint.string(from: games[indexRow ?? 0].released)
        }
    }
}

extension FavoriteListController: UISearchBarDelegate {
    
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search game"
        searchController.obscuresBackgroundDuringPresentation = false
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            self.games = gamesFiltered
            self.favoriteTableView.reloadData()
            return
        }
        
        self.games = gamesFiltered.filter({ (data) -> Bool in
            return data.name.lowercased().contains(searchText.lowercased())
        })
        
        self.favoriteTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.games = gamesFiltered
        self.favoriteTableView.reloadData()
    }
}

//
//  GameDetailController.swift
//  GameCatalogueDicoding
//
//  Created by Kalfian on 09/08/20.
//  Copyright © 2020 Kalfian. All rights reserved.
//

import UIKit
import Cosmos
import SafariServices


class GameDetailController: UIViewController {

    var id: Int?
    var gameUrl = ""
    var gameTitle = ""
    var gameRelease = ""
    var isFavorite = false
    var gameObj: GameObj = GameObj()
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var btwWebsite: UIButton!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var gameContent: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = gameTitle
        self.titleLabel.text = gameTitle
        self.releaseLabel.text = gameRelease
        
        favoriteButton.image = UIImage(systemName: "star")
        if isFavorite {
            favoriteButton.image = UIImage(systemName: "star.fill")
            getInternalData()
        } else {
            assignDataAPI()
        }
        
    }

    @IBAction func btwWebsiteDidTouchUp(_ sender: Any) {
        
        if self.gameUrl != "" {
            if let url = URL(string: self.gameUrl) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true

                let vc = SFSafariViewController(url: url, configuration: config)
                present(vc, animated: true)
            }
        }
        
    }
    
    fileprivate func getInternalData() {
        self.showLoad()
        if let id = id {
            self.gameObj = GameServiceDB.shared.getByID(id: id)
            
            self.setData()
            self.hideLoad()
        }
        
        
    }
    
    fileprivate func assignDataAPI() {
        self.showLoad()
        
        guard let id = self.id else {
            self.hideLoad()
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        fetchData(id) { (game) in
            guard let gameData = game else {
                DispatchQueue.main.sync {
                    self.hideLoad()
                    self.navigationController?.popViewController(animated: true)
                }
                return
            }
            
            self.gameObj = gameData.ConvertToObject()
            
           
            
            DispatchQueue.main.sync {
                self.setData()
                self.hideLoad()
            }
            
        }
    }
    
    fileprivate func showLoad() {
        favoriteButton.isEnabled = false
        self.showLoader(withTitle: "", and: "")
    }
    
    fileprivate func hideLoad() {
        favoriteButton.isEnabled = true
        self.hideLoader()
    }
    
    fileprivate func setData() {
        let data = self.gameObj.clone()
        
        self.gameUrl = data.website
        self.ratingView.rating = Double(data.rating)
        self.ratingLabel.text = String(data.rating)

        self.gameContent.attributedText = data.gameDescription.convertHtmlToAttributedStringWithCSS(color: Constant.Color.black)
        let image = data.backgroundImage
        self.gameImage.loadImage(url: image)
        
        self.isFavorite = checkFavorite()
        setFavoriteBtn()
    }
    
    fileprivate func fetchData(_ id: Int, completionHandler: @escaping(_ game: Game?) -> Void){
        GameServiceApi.shared.fetchDetail(id: id) { (result: Result<Game, GameServiceApi.APIServiceError>) in
            switch result {
                case .success(let gameResponse):
                    completionHandler(gameResponse)
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(nil)
            }
        }
    }
    
    @IBAction func btnFavoriteDidTouch(_ sender: Any) {
        self.isFavorite = !self.isFavorite
        
        if isFavorite {
            
            if GameServiceDB.shared.addData(obj: self.gameObj) {
                favoriteButton.image = UIImage(systemName: "star.fill")
                
                Helper.shared.alertGenerator(title: "Info", message: "Berhasil Memasukkan game kedalam favorite", controller: self)
            }
            
        } else {
            // Create New Object to Avoid invalidate object
            let gameObjCopy = self.gameObj.clone()
            
            if GameServiceDB.shared.deleteData(id: self.gameObj.id) {
                favoriteButton.image = UIImage(systemName: "star")
                self.gameObj = gameObjCopy
                Helper.shared.alertGenerator(title: "Info", message: "Berhasil Menghapus game dari favorite", controller: self)
            }
        }
        
        setFavoriteBtn()
    }
    
    fileprivate func checkFavorite() -> Bool {
        let gameFav: GameObj = GameServiceDB.shared.getByID(id: self.gameObj.id)
        
        if gameFav.id != 0 {
            return true
        }
        
        return false
        
    }
    
    fileprivate func setFavoriteBtn() {
        favoriteButton.image = UIImage(systemName: "star")
        if isFavorite {
            favoriteButton.image = UIImage(systemName: "star.fill")
        }
    }
}

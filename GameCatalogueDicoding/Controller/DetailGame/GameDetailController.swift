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
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var btwWebsite: UIButton!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var gameContent: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = gameTitle
        self.titleLabel.text = gameTitle
        
        assignData()
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
    
    fileprivate func assignData() {
        self.showLoader(withTitle: "", and: "")
        
        guard let id = self.id else {
            self.hideLoader()
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        fetchData(id) { (game) in
            guard let gameData = game else {
                DispatchQueue.main.sync {
                    self.hideLoader()
                    self.navigationController?.popViewController(animated: true)
                }
                return
            }
            
            
            self.gameUrl = gameData.website
            
            DispatchQueue.main.sync {
                self.ratingView.rating = Double(gameData.rating)
                self.ratingLabel.text = String(gameData.rating)

                self.gameContent.attributedText = gameData.description.convertHtmlToAttributedStringWithCSS(color: Constant.Color.BLACK)
                let image = gameData.backgroundImage
                self.gameImage.loadImage(url: image)
                self.hideLoader()
            }
            
        }
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
}

//
//  AboutMeController.swift
//  GameCatalogueDicoding
//
//  Created by Kalfian on 19/07/20.
//  Copyright © 2020 Kalfian. All rights reserved.
//

import UIKit
import SafariServices

class AboutMeController: UIViewController {

    @IBOutlet weak var labelNameText: UILabel!
    let userDefault = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setProfile()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    fileprivate func setProfile() {
        let name = userDefault.string(forKey: Constant.UserDefaultKey.name) ?? Constant.Profile.name
        labelNameText.text = name
    }
    
    @IBAction func getInTouchBtnDidTouchUp(_ sender: Any) {
        let link = userDefault.string(forKey: Constant.UserDefaultKey.url) ?? Constant.Profile.url
        
        if let url = URL(string: link) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    @IBAction func btnEditDidTouchUp(_ sender: Any) {
        self.performSegue(withIdentifier: Constant.Segue.editProfile, sender: self)
    }
    
}

//
//  ApplicationInformationController.swift
//  GameCatalogueDicoding
//
//  Created by Kalfian on 19/07/20.
//  Copyright © 2020 Kalfian. All rights reserved.
//

import UIKit

class ApplicationInformationController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        versionLabel.text = "Version 1.0.0"
        
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") {
            versionLabel.text = "Version \(version)"
        }
        // Do any additional setup after loading the view.
    }
}

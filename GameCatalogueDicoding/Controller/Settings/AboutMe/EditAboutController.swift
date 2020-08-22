//
//  EditAboutController.swift
//  GameCatalogueDicoding
//
//  Created by Kalfian on 18/08/20.
//  Copyright © 2020 Kalfian. All rights reserved.
//

import UIKit

class EditAboutController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!

    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
    }

    @IBAction func btnUpdateProfileDidTouch(_ sender: Any) {
        setData()
    }
    
    fileprivate func setData() {
        
        let url = urlTextField.text ?? Constant.Profile.url
        
        if Helper.shared.isValidUrl(url: url) {
            userDefault.set(url, forKey: Constant.UserDefaultKey.url)
        } else {
            Helper.shared.alertGenerator(title: "Info", message: "URL Tidak valid!", controller: self)
            return
        }
        
        let name = nameTextField.text ?? Constant.Profile.name
        userDefault.set(name, forKey: Constant.UserDefaultKey.name)
        
        getData()
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func getData() {
        let name = userDefault.string(forKey: Constant.UserDefaultKey.name) ?? Constant.Profile.name
        nameTextField.text = name
        
        let url = userDefault.string(forKey: Constant.UserDefaultKey.url) ?? Constant.Profile.url
        urlTextField.text = url
    }
    
}

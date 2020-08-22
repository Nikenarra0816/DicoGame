//
//  UIViewController+Extension.swift
//  GameCatalogueDicoding
//
//  Created by Kalfian on 08/08/20.
//  Copyright © 2020 Kalfian. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
   func showLoader(withTitle title: String, and Description:String) {
      let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
      indicator.label.text = title
      indicator.isUserInteractionEnabled = false
      indicator.detailsLabel.text = Description
      indicator.show(animated: true)
   }
   func hideLoader() {
      MBProgressHUD.hide(for: self.view, animated: true)
   }
}

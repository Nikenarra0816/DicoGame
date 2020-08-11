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
      let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
      Indicator.label.text = title
      Indicator.isUserInteractionEnabled = false
      Indicator.detailsLabel.text = Description
      Indicator.show(animated: true)
   }
   func hideLoader() {
      MBProgressHUD.hide(for: self.view, animated: true)
   }
}

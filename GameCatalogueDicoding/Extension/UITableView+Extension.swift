//
//  UITableView+Extension.swift
//  GameCatalogueDicoding
//
//  Created by Kalfian on 09/08/20.
//  Copyright © 2020 Kalfian. All rights reserved.
//

import UIKit
extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = EmptyView()
        
        emptyView.title.text = title
        emptyView.message.text = message
        
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore(separator: UITableViewCell.SeparatorStyle) {
        self.backgroundView = nil
        self.separatorStyle = separator
    }
}

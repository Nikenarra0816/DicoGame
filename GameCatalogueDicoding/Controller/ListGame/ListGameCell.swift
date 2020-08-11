//
//  ListGameCell.swift
//  GameCatalogueDicoding
//
//  Created by Kalfian on 19/07/20.
//  Copyright © 2020 Kalfian. All rights reserved.
//

import UIKit

class ListGameCell: UITableViewCell {
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

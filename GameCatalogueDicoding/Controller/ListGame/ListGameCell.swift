//
//  ListGameCell.swift
//  GameCatalogueDicoding
//
//  Created by Kalfian on 19/07/20.
//  Copyright © 2020 Kalfian. All rights reserved.
//

import UIKit
import Cosmos

class ListGameCell: UITableViewCell {
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameRelease: UILabel!
    @IBOutlet weak var gameRating: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

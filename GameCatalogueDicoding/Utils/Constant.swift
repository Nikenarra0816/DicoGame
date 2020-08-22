//
//  Constant.swift
//  GameCatalogueDicoding
//
//  Created by Kalfian on 19/07/20.
//  Copyright © 2020 Kalfian. All rights reserved.
//

import UIKit

struct Constant {
    
    struct Image {
        static let PLACE_HOLDER = "PlaceHolder"
    }
    
    struct Segue {
        static let aboutMe = "goToAboutMe"
        static let applicationInformation = "goToApplicationInformation"
        static let detailGame = "goToDetailGame"
        static let editProfile = "goToEditProfile"
    }
    
    struct Nib {
        static let listGameCell = "ListGameCell"
        static let listGameIdentifier = "listGame"
        
        static let emptyListGameCell = "EmptyGameCell"
        static let emptyListGameIdentifier = "emptyGameCell"
    }
    
    struct Profile {
        static let name = "Kukuh Alfian Hanif"
        static let url = "https://www.kalfian.com/"
    }
    
    struct Url {
        static let gameUrl = "https://api.rawg.io/"
    }
    
    struct Color {
        static let black = UIColor(named: "BlackColor") ?? UIColor.black
        static let white = UIColor(named: "WhiteColor") ?? UIColor.white
        static let gray = UIColor(named: "GrayColor") ?? UIColor.gray
    }
    
    struct UserDefaultKey {
        static let name = "name"
        static let url = "url"
    }
}

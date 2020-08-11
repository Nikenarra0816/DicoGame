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
        static let ABOUT_ME = "goToAboutMe"
        static let APPLICATION_INFORMATION = "goToApplicationInformation"
        static let DETAIL_GAME = "goToDetailGame"
    }
    
    struct Nib {
        static let LIST_GAME_CELL = "ListGameCell"
        static let LIST_GAME_IDENTIFIER = "listGame"
        
        static let EMPTY_LIST_GAME_CELL = "EmptyGameCell"
        static let EMPTY_LIST_GAME_IDENTIFIER = "emptyGameCell"
    }
    
    struct Url {
        static let GAME_URL = "https://api.rawg.io/"
        static let PORTO = "https://www.kalfian.com/"
    }
    
    struct Color {
        static let BLACK = UIColor(named: "BlackColor") ?? UIColor.black
        static let WHITE = UIColor(named: "WhiteColor") ?? UIColor.white
        static let GRAY = UIColor(named: "GrayColor") ?? UIColor.gray
    }
}

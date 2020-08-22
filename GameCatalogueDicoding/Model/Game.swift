//
//  Game.swift
//  GameCatalogueDicoding
//
//  Created by Kalfian on 01/08/20.
//  Copyright © 2020 Kalfian. All rights reserved.
//

import UIKit
import RealmSwift

struct GameResponse: Codable {
    
    let results: [Game]
    let next: String?
    let previous: String?
    
    enum CodingKeys: String, CodingKey {
        case next = "next"
        case results = "results"
        case previous = "previous"
    }
        
}

struct Game: Codable {
    let id: Int
    let backgroundImage: String
    let name: String
    let rating: Float
    let description: String
    let website: String
    let released: Date
    
    enum CodingKeys: String, CodingKey {
        case backgroundImage = "background_image"
        case id = "id"
        case name = "name"
        case rating = "rating"
        
        case description = "description"
        case website = "website"
        case released = "released"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        
        do {
            backgroundImage = try container.decode(String.self, forKey: .backgroundImage)
        } catch {
            backgroundImage = ""
        }
        
        name = try container.decode(String.self, forKey: .name)
        rating = try container.decode(Float.self, forKey: .rating)
        
        do {
            description = try container.decode(String.self, forKey: .description)
        } catch {
            description = ""
        }
        
        do {
            website = try container.decode(String.self, forKey: .website)
        }  catch {
            website = ""
        }
        
        do {
            let dateString = try container.decode(String.self, forKey: .released)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)!
            released = date
        } catch {
            released = Date()
        }
        
        
    }
    

    func ConvertToObject() -> GameObj {
        let gameObj = GameObj()
        
        gameObj.id = self.id
        gameObj.backgroundImage = self.backgroundImage
        gameObj.name = self.name
        gameObj.rating = self.rating
        gameObj.gameDescription = self.description
        gameObj.website = self.website
        gameObj.released = self.released
        
        return gameObj
    }
    
}

// MARK:- Realm Object

class GameObj: Object {
    @objc dynamic var id = 0
    @objc dynamic var backgroundImage = ""
    @objc dynamic var name = ""
    @objc dynamic var rating: Float = 0.0
    @objc dynamic var gameDescription = ""
    @objc dynamic var website = ""
    @objc dynamic var released = Date()
    
    override static func primaryKey() -> String? {
          return "id"
    }
    
    func clone() -> GameObj {
        let game = GameObj()
        game.id = self.id
        game.backgroundImage = self.backgroundImage
        game.name = self.name
        game.rating = self.rating
        game.gameDescription = self.gameDescription
        game.website = self.website
        game.released = self.released
        
        return game
    }
}

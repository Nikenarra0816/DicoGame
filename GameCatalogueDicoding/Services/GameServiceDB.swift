//
//  GameServiceDB.swift
//  GameCatalogueDicoding
//
//  Created by Kalfian on 16/08/20.
//  Copyright © 2020 Kalfian. All rights reserved.
//

import UIKit
import RealmSwift

class GameServiceDB {
    private var database: Realm
    static let shared = GameServiceDB()
    
    private init() {
        database = try! Realm()
    }
    
    func getUrl() -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    
    func getData  () -> [GameObj] {
        let results: Results<GameObj> = database.objects(GameObj.self)
        var datas: [GameObj] = []
        
        for data in results {
            datas.append(data)
        }
        
        return datas
    }
    
    func addData(obj: GameObj) -> Bool {
        do {
            try database.write{
                database.add(obj)
            }
            
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
        
    }
    
    func deleteData(id: Int) -> Bool {
        if let game = database.objects(GameObj.self).filter("id = %@", id).first {
            do {
                try database.write{
                    database.delete(game)
                }
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        }
        return false
    }
    
    func getByID (id: Int) -> GameObj {
        let game = database.objects(GameObj.self).filter("id = %@", id).first
        
        return game ?? GameObj()
    }
}

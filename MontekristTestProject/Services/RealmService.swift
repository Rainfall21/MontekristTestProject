//
//  RealmService.swift
//  MontekristTestProject
//
//  Created by Alibek Ismagulov on 14.08.2023.
//

import RealmSwift
import SwiftUI

class RealmService: RealmServiceProtocol {
    
    //try! realm ubrat'
    
    let realm = try! Realm()
    
    func add(_ item: ItemModel) {
        let favoritesList = Favorites(type: item.type, param1: item.parameter1, param2: item.parameter2, param3: item.parameter3, param4: item.parameter4)
        if findItem(item) == false {
            try! realm.write {
                realm.add(favoritesList)
            }
        }
    }
    
    func readFavorites() -> [ItemModel] {
        let favoritesList = realm.objects(Favorites.self)
        let favorites = favoritesList.map { favoritesList in
            ItemModel(type: favoritesList.type, parameter1: favoritesList.param1, parameter2: favoritesList.param2, parameter3: favoritesList.param3, parameter4: favoritesList.param4)
        }
        return Array(favorites)
    }
    
    func delete(_ item: ItemModel) {
        _ = readFavorites()
        try! realm.write {
            realm.delete(realm.objects(Favorites.self).filter("param1 == '\(item.parameter1)'"))
        }
    }
    
    func findItem(_ item: ItemModel) -> Bool {
        let favirotesInRealm = realm.objects(Favorites.self)
        let specificItem = favirotesInRealm.where {
            $0.param1 == "\(item.parameter1)"
        }
        return specificItem.first != nil
    }
}

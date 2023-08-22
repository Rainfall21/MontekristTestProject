//
//  ItemModel.swift
//  MontekristTestProject
//
//  Created by Alibek Ismagulov on 16.08.2023.
//

import Foundation
import RealmSwift

struct ItemResult: Codable {
    var results : [ItemModel]
}

struct ItemModel: Codable, Identifiable {
    
    var id: String {
        parameter1
    }

    var type: String
    var parameter1: String
    var parameter2: String
    var parameter3: String?
    var parameter4: String?
    
    enum RequestType {
        case person
        case planet
        case starship
        case film
    }

    enum PersonCodingKeys: String, CodingKey {
        case parameter1 = "name"
        case parameter2 = "gender"
        case parameter5 = "starships"
    }
    enum FilmCodingKeys: String, CodingKey {
        case parameter1 = "title"
        case parameter2 = "director"
        case parameter3 = "producer"
    }
    enum PlanetCodingKeys: String, CodingKey {
        case parameter1 = "name"
        case parameter2 = "diameter"
        case parameter3 = "population"
    }
    enum StarshipsCodingKeys: String, CodingKey {
        case parameter1 = "name"
        case parameter2 = "model"
        case parameter3 = "manufacturer"
        case parameter4 = "passengers"
    }
}

//
//  StarshipModel.swift
//  MontekristTestProject
//
//  Created by Alibek Ismagulov on 14.08.2023.
//

import Foundation
import RealmSwift

struct StarshipModel: Codable, Identifiable {
    
    var id: String {
        name
    }
    
    let name: String
    let model: String
    let manufacturer: String
    let passengers: String
}

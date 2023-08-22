//
//  PersonModel.swift
//  MontekristTestProject
//
//  Created by Alibek Ismagulov on 14.08.2023.
//

import Foundation
import RealmSwift

struct PersonModel : Codable, Identifiable {
    
    var id: String {
        name
    }
    
    let name: String
    let gender: String
    let starships: [String]?
}

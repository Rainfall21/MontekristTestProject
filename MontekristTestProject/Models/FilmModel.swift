//
//  ItemModel.swift
//  MontekristTestProject
//
//  Created by Alibek Ismagulov on 14.08.2023.
//

import Foundation
import RealmSwift

struct FilmModel: Codable, Identifiable {
    
    var id: String {
        title
    }
    
    let title: String
    let director: String
    let producer: String
}

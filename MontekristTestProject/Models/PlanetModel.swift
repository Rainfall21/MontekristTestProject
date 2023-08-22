//
//  PlanetsModel.swift
//  MontekristTestProject
//
//  Created by Alibek Ismagulov on 14.08.2023.
//

import Foundation
import RealmSwift

struct PlanetModel: Codable, Identifiable {
    
    var id: String {
        name
    }
    
    let name: String
    let diameter: String
    let population: String
}

//
//  RealmServiceProtocol.swift
//  MontekristTestProject
//
//  Created by Alibek Ismagulov on 14.08.2023.
//

import Foundation
import SwiftUI
import RealmSwift

protocol RealmServiceProtocol {
    
    func add(_ item: ItemModel) -> Void
    func readFavorites() -> [ItemModel]
    func delete(_ item: ItemModel) -> Void
    func findItem(_ item: ItemModel) -> Bool
}

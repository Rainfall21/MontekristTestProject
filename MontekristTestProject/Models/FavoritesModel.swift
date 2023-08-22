//
//  FavoritesModel.swift
//  MontekristTestProject
//
//  Created by Alibek Ismagulov on 21.08.2023.
//

import Foundation
import RealmSwift

class Favorites: Object, ObjectKeyIdentifiable {
    
    @Persisted var type = ""
    @Persisted var param1 = ""
    @Persisted var param2 = ""
    @Persisted var param3 = ""
    @Persisted var param4 = ""

    convenience init(type:String = "", param1: String = "", param2: String = "", param3: String? = "", param4: String? = "") {
        self.init()
        self.type = type
        self.param1 = param1
        self.param2 = param2
        self.param3 = param3 ?? ""
        self.param4 = param4 ?? ""
    }
}

class ReloadViewHelper: ObservableObject {
    func reloadView() {
        objectWillChange.send()
    }
}

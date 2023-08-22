//
//  ResponseModel.swift
//  MontekristTestProject
//
//  Created by Alibek Ismagulov on 15.08.2023.
//

import Foundation

struct FetchResult<T:Codable>: Codable {
    var results : [T]
}

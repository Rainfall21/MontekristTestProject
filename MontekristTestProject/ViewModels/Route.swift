//
//  Route.swift
//  MontekristTestProject
//
//  Created by Alibek Ismagulov on 15.08.2023.
//

import Foundation

enum Route {
    static let baseUrl = "https://swapi.dev/api"
    
    case people(String)
    case planets(String)
    case starships(String)
    case films(String)
    
    var description: String {
        switch self {
            
        case .people(let searchText):
            return "/people/?search=\(modifySearchText(text: searchText))"
        case .planets(let searchText):
            return "/planets/?search=\(modifySearchText(text: searchText))"
        case .starships(let searchText):
            return "/starships/?search=\(modifySearchText(text: searchText))"
        case .films(let searchText):
            return "/films/?search=\(modifySearchText(text: searchText))"
        }
    }
}

func modifySearchText(text: String) -> String {
        let pattern = "\\s+$"
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(text.startIndex..., in: text)
        let trimmed = regex.stringByReplacingMatches(in: text, options: [], range: range, withTemplate: "")
        let searchText = trimmed.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        
        return searchText
    }

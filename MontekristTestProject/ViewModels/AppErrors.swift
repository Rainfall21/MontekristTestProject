//
//  AppErrors.swift
//  MontekristTestProject
//
//  Created by Alibek Ismagulov on 16.08.2023.
//

import Foundation

enum AppError: LocalizedError {
    case errorDecoding
    case unknownError
    case invalidURL
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Can't decode"
        case .unknownError:
            return "Unknown Error"
        case .invalidURL:
            return "Invalid URL"
        case .serverError(let error):
            return error
        }
    }
}

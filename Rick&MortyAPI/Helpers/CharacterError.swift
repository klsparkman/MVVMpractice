//
//  CharacterError.swift
//  Rick&MortyAPI
//
//  Created by Kelsey Sparkman on 3/17/21.
//

import Foundation

enum CharacterError: LocalizedError {
    // What we see
    case invalidURL
    case thrown(Error)
    case noData
    case unableToDecode
    
    // What the user sees
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach server."
        case .thrown(let error):
            return error.localizedDescription
        case .noData:
            return "Server responded with no data."
        case .unableToDecode:
            return "Server responded with bad data"
        }
    }
}

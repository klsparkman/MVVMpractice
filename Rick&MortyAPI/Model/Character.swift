//
//  Character.swift
//  Rick&MortyAPI
//
//  Created by Kelsey Sparkman on 3/17/21.
//

import Foundation

struct TopLevelObject: Codable {
    let results: [Character]
}

struct Character: Codable {
    let name: String
    let status: String
    let species: String
    let image: String
}

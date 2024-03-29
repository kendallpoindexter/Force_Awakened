//
//  CharacterModel.swift
//  Project_Force_Awakened
//
//  Created by Kendall Poindexter on 11/8/19.
//  Copyright © 2019 Kendall Poindexter. All rights reserved.
//

import Foundation

struct APIcharacter: Decodable {
    let name: String
    let birthYear: String
    let gender: String
    let homeworld: String
    let species: [String]
}

extension APIcharacter {
    enum CharacterCodingKeys: String, CodingKey {
        case name
        case birthYear = "birth_year"
        case gender
        case homeworld
        case species
    }
}

//
//  SWCharacterModel.swift
//  Project_Force_Awakened
//
//  Created by Kendall Poindexter on 11/14/19.
//  Copyright © 2019 Kendall Poindexter. All rights reserved.
//

import Foundation

class SWCharacter {
    var name: String
    var birthYear: String
    var gender: String
    var homeworld: String
    var species: [Species]

    init(name: String, birthYear: String, gender: String, homeworld: String, species: [Species]) {
        self.name = name
        self.birthYear = birthYear
        self.gender = gender
        self.homeworld = homeworld
        self.species = species
    }
}

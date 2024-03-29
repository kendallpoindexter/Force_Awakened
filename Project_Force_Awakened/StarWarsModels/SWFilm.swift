//
//  SWFilm.swift
//  Project_Force_Awakened
//
//  Created by Kendall Poindexter on 11/14/19.
//  Copyright © 2019 Kendall Poindexter. All rights reserved.
//

import Foundation

class SWFilm {
    var title: String
    var episodeID: Int
    var characters: [SWCharacter]

    init(title: String, episodeID: Int, characters: [SWCharacter]) {
        self.title = title
        self.episodeID = episodeID
        self.characters = characters
    }
}

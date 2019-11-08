//
//  FilmModel.swift
//  Project_Force_Awakened
//
//  Created by Kendall Poindexter on 11/8/19.
//  Copyright © 2019 Kendall Poindexter. All rights reserved.
//

import Foundation

struct FilmModel {
    let title: String
    let episodeID: Int
    let characterURLStrings: [String]
}

extension FilmModel {
    enum CodingKeys: String, CodingKey {
        case title
        case episodeID = "episode_id"
        case characterURLStrings = "characters"
    }
}

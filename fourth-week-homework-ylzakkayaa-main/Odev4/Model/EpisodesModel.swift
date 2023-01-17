//
//  EpisodesModel.swift
//  Odev4
//
//  Created by Yeliz Akkaya on 26.11.2022.
//

//Episodes modelini tanımladım.

import Foundation

struct EpisodesModel: Codable {
    let episodesName: String
    let seasons: String
    let characters: [String]
    let episode: String
    
    enum CodingKeys: String, CodingKey {
        case episodesName = "title"
        case seasons = "season"
        case characters = "characters"
        case episode = "episode"
    }
}

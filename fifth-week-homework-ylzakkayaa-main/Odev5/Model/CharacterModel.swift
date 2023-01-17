//
//  File.swift
//  Odev4
//
//  Created by Yeliz Akkaya on 23.11.2022.
//

//Charakter modelini tanımladım.
import Foundation

struct CharacterModel: Codable {
    let name: String
    let birthday: String
    let nickname: String
    let photoUrl: String
    let liveStatus: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case birthday = "birthday"
        case nickname = "nickname"
        case photoUrl = "img"
        case liveStatus = "status"
    }
}

//
//  File.swift
//  Odev4
//
//  Created by Yeliz Akkaya on 26.11.2022.
//

//Quote modelini tanımladım.

import Foundation

struct QuoteModel: Codable {
    let quote: String
    let author: String
    
    enum CodingKeys: String, CodingKey {
        case quote = "quote"
        case author = "author"
    }
}

//
//  BaseResponse.swift
//  Odev3
//
//  Created by Yeliz Akkaya on 19.11.2022.
//

import Foundation

struct BaseResponse: Codable {
    let status: Int
    let error: String
}

extension BaseResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}

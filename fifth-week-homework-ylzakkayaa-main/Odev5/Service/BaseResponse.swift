//
//  BaseResponse.swift
//  Odev4
//
//  Created by Yeliz Akkaya on 23.11.2022.
//

import Foundation

struct BaseResponse: Codable {
    let name: String
    let birthday: String
    let nickname: String
    let photoUrl: String
    let liveStatus: String
    let error: String
}

extension BaseResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}

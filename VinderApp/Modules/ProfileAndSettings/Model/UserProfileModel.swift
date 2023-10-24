//
//  UserProfileModel.swift
//  VinderApp
//
//  Created by iOS Dev on 19/10/2023.
//

import Foundation

// MARK: - Events List
struct UserSportsInterestModel: Decodable {
    let response: UserSportsInterestList?
}

struct UserSportsInterestList: Decodable {
    let messages: [String]?
    let data: [SportsInterest]?
}

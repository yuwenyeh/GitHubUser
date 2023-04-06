//
//  UserDataModel.swift
//  GitHubUser
//
//  Created by 葉育彣 on 2023/4/6.
//

import Foundation

struct  UserDataModel: Decodable {
    let name: String
    let image: String
    let admin: Bool
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case image = "avatar_url"
        case admin = "site_admin"
    }
}

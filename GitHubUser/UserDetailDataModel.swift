//
//  UserDetailDataModel.swift
//  GitHubUser
//
//  Created by 葉育彣 on 2023/4/17.
//

import Foundation
struct UserDetailDataModel: Decodable {
    var login: String?
    var avatarUrl: String?
    var htmlUrl: String?
    var name: String?
    var twitterName: String?
    var followers: Int?

    var following: Int?
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case name = "name"
        case twitterName = "twitter_username"
        case followers = "followers_url"
        case following = "following_url"
    }
}

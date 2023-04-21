//
//  MockData.swift
//  GitHubUserTests
//
//  Created by 葉育彣 on 2023/4/21.
//

@testable import GitHubUser

extension UserDataModel {
    static func stub(name: String = "MockName",
                     image: String = "MockImage",
                     admin: Bool = true) -> Self {
        UserDataModel(name: name, image: image, admin: admin)
    }
}

extension UserDetailDataModel {
    static func stub(login: String = "123",
                     name: String = "Mock",
                     following: Int = 145) -> Self {
        UserDetailDataModel(login:login, name: name, following: following)
    }
}

//
//  HttpRequestViewModel.swift
//  GitHubUser
//
//  Created by Emp-210204 on 2023/4/11.
//

import Foundation


class GitHubRepository {
    
    static func getUserDataModel(num: Int)-> String{
        let url = "https://api.github.com/users?since=0&per_page=\(num)"
        return url
    }
    
    
}

//
//  UserDetailViewModel.swift
//  GitHubUser
//
//  Created by 葉育彣 on 2023/3/29.
//

import Foundation

protocol UserListDetailViewModelType {
    var userDetail: Observable <UserDetailDataModel>{get}
    func getUserDetail(name: String)
    
}

final class UserDetailViewModel: UserListDetailViewModelType {
    func getUserDetail(name: String) {
        <#code#>
    }
    
    var userDetail: Observable<UserDetailDataModel> = Observable(UserDetailDataModel())
    
    
    init(userDetailName: String) {
        
    }
    
    
}

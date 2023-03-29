//
//  UserListViewModel.swift
//  GitHubUser
//
//  Created by 葉育彣 on 2023/3/28.
//

import Foundation

protocol UserListViewModelType {
    var userList: Observable <[UserDataModel]> {get}
    var error: Observable <String?> {get}
    func getUserList()
}
final class UserListViewModel: UserListViewModelType {
    var error: Observable<String?> = Observable(.none)
    var userList: Observable<[UserDataModel]> = Observable([])
    func getUserList() {
        let urlStr = "https://api.github.com/users?since=0&per_page=100"
        guard let url = URL(string: urlStr) else {return}
        URLSession.shared.dataTask(with: url) {( data, response, error ) in
            if let error {
                print("Error")
                self.error.value = error.localizedDescription
                return
            }
            guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else { return }
            guard let data else { return }
            do {  let decoder = JSONDecoder()
                let jsonData = try decoder.decode([UserDataModel].self, from: data)
                self.userList.value = jsonData
            } catch let error {
                self.error.value = error.localizedDescription
            }
        }.resume()
    }
}

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

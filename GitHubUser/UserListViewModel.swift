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
    let repository: UserListRepositoryType
    init(repository: UserListRepositoryType) {
        self.repository = repository
    }
    func getUserList() {
        let urlStr = "https://api.github.com/users?since=0&per_page=100"
        repository.getUserList(urlString: urlStr) { result in
            switch result {
            case .success(let value):
                self.userList.value = value
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
    }
}
protocol UserListRepositoryType {
    func getUserList(urlString: String,
                     completion: @escaping(Result<[UserDataModel], Error>) -> Void)
}

struct UserListRepository: UserListRepositoryType {
    func getUserList(urlString: String, completion: @escaping(Result<[UserDataModel], Error>) -> Void) {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) {( data, response, error ) in
            if let error {
            print("Error")
                // self.error.value = error.localizedDescription
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else { return }
            guard let data else { return }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([UserDataModel].self, from: data)
                // self.userList.value = jsonData
                completion(.success(jsonData))
            } catch let error {
                // 失敗
                completion(.failure(error))
                // self.error.value = error.localizedDescription
            }
        }.resume()
    }
}



//
//  UserDetailViewModel.swift
//  GitHubUser
//
//  Created by 葉育彣 on 2023/3/29.
//

import Foundation

protocol UserDetailViewModelType {
    var userDetail: Observable < UserDetailDataModel > { get }
    var error: Observable< String? > { get }
    func getUserDetail()
}

final class UserDetailViewModel: UserDetailViewModelType {
    var error: Observable< String? > = Observable(.none)
    var userDetail: Observable<UserDetailDataModel> = Observable(UserDetailDataModel())
    let respository: UserDetailRepositoryType
    var userDetailModel: UserDataModel
    init(userDetail: UserDataModel, respository: UserDetailRepositoryType) {
        userDetailModel = userDetail
        self.respository = respository
    }
    func getUserDetail() {
        let url = GitHubRepository.getUserDetailDataModel(name: userDetailModel.name)
        respository.getUserDetail(userStr: url) { result in
            switch result {
            case .success(let value):
                self.userDetail.value = value
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
    }
}

protocol UserDetailRepositoryType {
    func getUserDetail( userStr : String,
                        completion: @escaping(Result < UserDetailDataModel, Error>) -> Void)
 }

struct UserDetailRepository: UserDetailRepositoryType {
    func getUserDetail(userStr: String, completion: @escaping (Result<UserDetailDataModel, Error>) -> Void) {
        guard let url = URL(string: userStr) else {return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error {
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse,
            (200...299).contains(response.statusCode) else {return}
             guard let data else {return}
            do {
            let decoder = JSONDecoder()
                let jsonData = try decoder.decode(UserDetailDataModel.self, from: data)
                completion(.success(jsonData))
        } catch let error {
            completion(.failure(error))
        }
        }.resume()
    }
}

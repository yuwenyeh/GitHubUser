//
//  GitHubUserTests.swift
//  GitHubUserTests
//
//  Created by 葉育彣 on 2023/3/27.
//

import XCTest
@testable import GitHubUser

final class UserListViewModelTests: XCTestCase {

    func test_getUserList_successGetOneUserData() {
        // given準備好的測試材料
        let value = [UserDataModel.stub()]
        let expectation = XCTestExpectation(description: "should get data successfully")
        let repo = MockUserListRepository(value: value, error: nil, successExpectation: expectation)
        let sut = UserListViewModel(repository: repo)
        // when 測試使用的情境
        sut.getUserList()
        // 主
        // then得到結果
        XCTAssertEqual(sut.userList.value.count, 1)
        XCTAssertEqual(sut.userList.value.first?.name, "MockName")
        XCTAssertEqual(sut.userList.value.first?.image, "MockImage")
        XCTAssertEqual(sut.userList.value.first?.admin, true)
        //檢查預期有無滿足，在0.5秒內滿足否則報錯
        wait(for: [expectation], timeout: 0.5)
    }
}

struct MockUserListRepository: UserListRepositoryType {
    let value: [UserDataModel]?
    let error: Error?
    let failExpectation: XCTestExpectation?
    let successExpectation: XCTestExpectation?
    init(value: [UserDataModel]?,
         error: Error?,
         failExpectation: XCTestExpectation? = nil,
         successExpectation: XCTestExpectation? = nil) {
        self.value = value
        self.error = error
        self.failExpectation = failExpectation
        self.successExpectation = successExpectation
    }
    func getUserList(urlString: String, completion: @escaping (Result<[UserDataModel], Error>) -> Void) {
        if let error {
            completion(.failure(error))
            // 滿足這個預期
            failExpectation?.fulfill()
            return
        }
        if let value {
            completion(.success(value))
            successExpectation?.fulfill()
            return
        }
        completion(.failure(MockError.noResponse))
    }
}
enum MockError: Error {
    case noResponse
    case badNetwork
}

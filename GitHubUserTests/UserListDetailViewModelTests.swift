//
//  UserListDetailViewModelTests.swift
//  GitHubUserTests
//
//  Created by 葉育彣 on 2023/4/17.
//

import XCTest
@testable import GitHubUser

final class UserListDetailViewModelTests: XCTestCase {
    func test_getUserDetail_successGetOneDetailData() {
        //定義預期
        let expectation = XCTestExpectation(description: "should get data successfully")
        let respository = MockUserDetailRepository(value: UserDetailDataModel.stub(), error: nil, successExpectation: expectation)
        let sut = UserDetailViewModel(userDetail: UserDataModel.stub(), respository: respository)
        sut.getUserDetail()
        XCTAssertEqual(sut.userDetail.value.name,"Mock")
        XCTAssertEqual(sut.userDetail.value.login, "123")
        XCTAssertEqual(sut.userDetail.value.following,145)
        wait(for: [expectation], timeout: 0.2)
    }
}

struct MockUserDetailRepository: UserDetailRepositoryType {
    let value: UserDetailDataModel?
    let error: Error?
    let failExpectation: XCTestExpectation?
    let successExpectation: XCTestExpectation?
    init(value: UserDetailDataModel,
         error: Error?,
         failExpectation: XCTestExpectation? = nil,
         successExpectation: XCTestExpectation? = nil) {
        self.value = value
        self.error = error
        self.failExpectation = failExpectation
        self.successExpectation = successExpectation
    }
    func getUserDetail(userStr: String, completion: @escaping (Result<UserDetailDataModel, Error>) -> Void) {
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

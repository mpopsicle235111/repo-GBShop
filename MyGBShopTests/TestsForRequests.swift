//
//  TestsForRequests.swift
//  MyGBShopTests
//
//  Created by Anton Lebedev on 12.07.2022.
//

import XCTest
import Alamofire
@testable import MyGBShop

class TestsForRequests: XCTestCase {
    var requestFactory: RequestFactory!
    var user: User!
    
    let expectation = XCTestExpectation(description: "Make a test of a request")
    let timeoutValue = 5.0 //Has to be Double explicitly
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        requestFactory = RequestFactory()
        user = User(id: 001,
                    login: "Jack007",
                    firstName: "Jack",
                    lastName: "Abramoff",
                    password: "sourCream2!",
                    email: "jackabramoff@aol.com",
                    gender: "m",
                    creditCardNumber: "1234567812345678",
                    tagLine: "Money rule the world!")
    }
    
    override func tearDownWithError() throws {
        try? super.tearDownWithError()
        requestFactory = nil
        user = nil
    }
    
    func testShouldPerformRegistRequest() {
        let factory = requestFactory.makeRegistRequestFactory()
        factory.register(user: user) { [weak self] response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, 1)
            case .failure:
                XCTFail()
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeoutValue)
    }
    
    func testShouldPerformAuthRequest() {
        let factory = requestFactory.makeAuthRequestFactory()
        factory.logout(userID: user.id ?? 0) { [weak self] response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, 1)
            case .failure:
                XCTFail()
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeoutValue)
    }
    
    func testShouldPerformChangeUserDataRequest() {
        let factory = requestFactory.makeСhangeUserDataFactory()
        factory.changeUserData(user: user) { [weak self] response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, 1)
            case .failure:
                XCTFail()
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeoutValue)
    }
    
    func testShouldPerformLogoutRequest() {
        let factory = requestFactory.makeAuthRequestFactory()
        factory.logout(userID: user.id ?? 0) { [weak self] response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, 1)
            case .failure:
                XCTFail()
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeoutValue)
    }
    
    func testShouldPerformGetCatalogueRequest() {
        let factory = requestFactory.makeGetCatalogueRequestFactory()
        factory.getCatalogue(pageNumber: 1, categoryNumber: 1) { [weak self] response in
            switch response.result {
            case .success: break
            case .failure:
                XCTFail()
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeoutValue)
    }
    
    func testShouldPerformGetItemRequest() {
        let factory = requestFactory.makeGetItemRequestFactory()
        factory.getItem(productIdNumber: 7) { [weak self] response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, 1)
            case .failure:
                XCTFail()
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeoutValue)
    }
    
    
}


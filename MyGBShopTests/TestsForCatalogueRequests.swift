//
//  TestsForCatalogueRequests.swift
//  MyGBShopTests
//
//  Created by Anton Lebedev on 21.07.2022.
//

import XCTest
import Alamofire
@testable import MyGBShop

class TestsForCatalogueRequests: XCTestCase {
    var requestFactory: RequestFactory!

    let expectation = XCTestExpectation(description: "Make a test of a request")
    let timeoutValue = 5.0 //Has to be Double explicitly

    override func setUpWithError() throws {
         try? super.setUpWithError()
         requestFactory = RequestFactory()

    }

    override func tearDownWithError() throws {
         try? super.tearDownWithError()
         requestFactory = nil

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

     func testShouldPerformGetItemByIdRequest() {
         let factory = requestFactory.makeGetItemRequestFactory()
         factory.getItem(productIdNumber: 1) { [weak self] response in
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


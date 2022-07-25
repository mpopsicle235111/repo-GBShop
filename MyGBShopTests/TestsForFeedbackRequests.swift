//
//  TestsForFeedbackRequests.swift
//  MyGBShopTests
//
//  Created by Anton Lebedev on 21.07.2022.
//

import XCTest
import Alamofire
@testable import MyGBShop

class TestsForFeedbackRequests: XCTestCase {
     var requestFactory: RequestFactory!

     let expectation = XCTestExpectation(description: "Perform request.")
     let timeoutValue = 5.0 //Has to be Double explicitly

     override func setUpWithError() throws {
         try? super.setUpWithError()
         requestFactory = RequestFactory()

     }

     override func tearDownWithError() throws {
         try? super.tearDownWithError()
         requestFactory = nil

     }

     func testShouldPerformGetFeedbackRequest() {
         let factory = requestFactory.makeFeedbackRequestFactory()

         factory.getFeedback(productIdNumber: 1) { response in
             switch response.result {
             case .success(let result): XCTAssertGreaterThan(result.count, 0)
             case .failure: XCTFail()
             }
             self.expectation.fulfill()
         }
         wait(for: [expectation], timeout: timeoutValue)
     }

     func testShouldPerformAddFeedbackRequest() {
         let factory = requestFactory.makeFeedbackRequestFactory()

         factory.addFeedback(feedback: FeedbackResult(userId: 1, feedbackText: "Very cool item", productIdNumber: 1)) { [weak self] response in
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

     func testShouldPerformRemoveFeedbackRequest() {
         let factory = requestFactory.makeFeedbackRequestFactory()

         factory.removeFeedback(feedback: FeedbackResult(userId: 1, feedbackText: "Very cool item", productIdNumber: 1)) { [weak self] response in
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

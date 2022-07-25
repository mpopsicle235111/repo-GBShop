//
//  TestsForShoppingCartRequests.swift
//  MyGBShopTests
//
//  Created by Anton Lebedev on 25.07.2022.
//

import XCTest
import Alamofire
@testable import MyGBShop

class TestsForShoppingCartRequests: XCTestCase {
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

     func testShouldPerformGetShoppingCartRequest() {
         let factory = requestFactory.makeShoppingCartRequestFactory()

         factory.getShoppingCart(user: User(id: 001)) { response in
             switch response.result {
             case .success(let result): XCTAssertNotNil(result.itemsCount)
                          case .failure: XCTFail()
                          }
                          self.expectation.fulfill()
                      }
                      wait(for: [expectation], timeout: timeoutValue)
     }

     func testShouldPerformPayForShoppingCartRequest() {
         let factory = requestFactory.makeShoppingCartRequestFactory()

         factory.payForShoppingCart(user: User(id: 001)) { [weak self] response in
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

     func testShouldPerformAddToShoppingCartRequest() {
         let factory = requestFactory.makeShoppingCartRequestFactory()

         factory.addToShoppingCart(shoppingCart: ShoppingCartRequest(itemId: 2, quantity: 2)) { [weak self] response in
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

     func testShouldPerformDeleteFromShoppingCartRequest() {
         let factory = requestFactory.makeShoppingCartRequestFactory()

         factory.deleteFromShoppingCart(shoppingCart: ShoppingCartRequest(itemId: 2, quantity: 2)) { [weak self] response in
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


//
//  MyGBShopTests.swift
//  MyGBShopTests
//
//  Created by Anton Lebedev on 19.06.2022.
//

import XCTest
@testable import MyGBShop

class MyGBShopTests: XCTestCase {

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func loginSuccessTest() throws {

        let app = XCUIApplication()
        app.launch()
        let loginView = app.otherElements["loginView"].firstMatch
        let loginTextField = loginView.textFields["loginTextField"].firstMatch
        let passwordTextField = loginView.textFields["passwordTextField"].firstMatch
        let loginButton = loginView.buttons["loginButton"].firstMatch
        let tabBarViewController = app.otherElements["tabBarViewController"].firstMatch

        print(app.debugDescription)

        //Let's emulate that we input login and password data
        loginTextField.tap()
        loginTextField.typeText("Jack007")

        passwordTextField.tap()
        passwordTextField.typeText("sourCream2!")

        loginButton.tap()
        XCTAssert(tabBarViewController.waitForExistence(timeout: 3))

    }

    func loginFailureTest() throws {
        let app = XCUIApplication()
        app.launch()
        let loginView = app.otherElements["loginView"].firstMatch
        let loginTextField = loginView.textFields["loginTextField"].firstMatch
        let passwordTextField = loginView.textFields["passwordTextField"].firstMatch
        let loginButton = loginView.buttons["loginButton"].firstMatch
        let alert = app.alerts.firstMatch

        loginTextField.tap()
        loginTextField.typeText("admin")

        passwordTextField.tap()
        passwordTextField.typeText("admin")

        loginButton.tap()
        XCTAssert(alert.waitForExistence(timeout: 2.0))
        alert.buttons.firstMatch.tap()

        XCTAssert(loginView.waitForExistence(timeout: 5))


        }
    
    func registrationTest() throws {

        let app = XCUIApplication()
        app.launch()
        let loginView = app.otherElements["loginView"].firstMatch
        let registerButton = loginView.buttons["registerButton"].firstMatch
        let registrationViewController = app.otherElements["registrationViewController"].firstMatch

        registerButton.tap()
        XCTAssert(registrationViewController.waitForExistence(timeout: 3))

         }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

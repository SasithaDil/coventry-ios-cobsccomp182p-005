//
//  CourseworkIOSUITests.swift
//  CourseworkIOSUITests
//
//  Created by Sasitha Dilshan on 3/3/20.
//  Copyright © 2020 Sasitha Dilshan. All rights reserved.
//

import XCTest

class CourseworkIOSUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
   
    func testLogin(){
        
        let email = "waruna12@gmail.com"
        let password = "pass@123"
        
        let app = XCUIApplication()
        
        let loginButton = app.buttons["Login"]
        loginButton.tap()
        
        let txtEmail = app.textFields["Email"]
        XCTAssertTrue(txtEmail.exists)
        txtEmail.tap()
        txtEmail.typeText(email)
        
        let txtPassword = app.secureTextFields["Password"]
        XCTAssertTrue(txtPassword.exists)
        txtPassword.tap()
        txtPassword.typeText(password)
        
        loginButton.tap()
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Events"].tap()
        tabBarsQuery.buttons["My Profile"].tap()
        app.buttons["Logout"].tap()
        
    }

}

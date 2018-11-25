//
//  TransferWise__Development__UITests.swift
//  TransferWise (Development) UITests
//
//  Created by Nam Nguyen on 25/11/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

import XCTest

class TransferWiseUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        setupSnapshot(app)
        app.launchArguments.append("--uitesting")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testListPostAvailable() {
        app.launch()
        print(app.tables)
        XCTAssertTrue(app.tables.element.exists, "Table view does not exists")
        snapshot("All posts")
    }
}

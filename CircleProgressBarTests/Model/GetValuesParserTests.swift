//
//  GetValuesParserTests.swift
//  CircleProgressBarTests
//
//  Created by Rodrigo Gonzalez on 09/02/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import XCTest
@testable import CircleProgressBar

class GetValuesParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParse() {
        let value = TestHelper.parser.parseValue(value: TestHelper.valueDictionary)
        XCTAssertNotNil(value.accountIDVStatus, "should have accountIDVStatus")
        XCTAssert(value.score > -1, "should have score")
        XCTAssert(value.maxScoreValue > -1, "should have max score")
        XCTAssert(value.minScoreValue > -1, "should have min score")
    }
}

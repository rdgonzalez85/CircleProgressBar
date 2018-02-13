//
//  GetValuesPresenterTests.swift
//  CircleProgressBarTests
//
//  Created by Rodrigo Gonzalez on 08/02/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import XCTest
@testable import CircleProgressBar

class GetValuesPresenterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetValues() {
        let presenterExpectation = expectation(description: "presenterExpectation")
        
        let presenter = TestHelper.presenterWith(expectation: presenterExpectation)
        
        presenter.getValues()
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

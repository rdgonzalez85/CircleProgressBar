//
//  MockGetPresenterDelegate.swift
//  CircleProgressBarTests
//
//  Created by Rodrigo Gonzalez on 12/02/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import XCTest

@testable import CircleProgressBar

class MockGetPresenterDelegate: NSObject, GetValuesPresenterDelegate {
    
    var expectation: XCTestExpectation?
    
    func valueReady(value:VisualValue) {
        expectation?.fulfill()
    }
}

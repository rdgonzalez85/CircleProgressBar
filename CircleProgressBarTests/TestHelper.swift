//
//  TestHelper.swift
//  CircleProgressBarTests
//
//  Created by Rodrigo Gonzalez on 09/02/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import XCTest
@testable import CircleProgressBar

struct TestHelper {
    static let urlEndpoint = "https://s3.amazonaws.com/cdn.clearscore.com/native/interview_test/creditReportInfo.json"
    
    static var provider: GetValuesProvider {
        get {
            return GetValuesNetworkProvider(endpointURL: TestHelper.urlEndpoint)
        }
    }
    
    static var parser: GetValuesParser {
        get {
            return GetValuesParserImp()
        }
    }

    static func presenterWith(expectation: XCTestExpectation) -> GetValuesPresenter {
        let provider = TestHelper.provider
        let parser = TestHelper.parser
        let delegate = MockGetPresenterDelegate()
        delegate.expectation = expectation
        
        return GetValuesPresenterImp(parser: parser, provider: provider, delegate: delegate)
    }
    
    static let valueDictionary: [String : Any] = [
        "accountIDVStatus": "PASS",
        "creditReportInfo": [  "score": 100.0,
                               "maxScoreValue": 700.0,
                               "minScoreValue": 0.0
                            ]
        ]
    
}

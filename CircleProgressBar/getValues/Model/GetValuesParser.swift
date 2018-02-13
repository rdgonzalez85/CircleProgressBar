//
//  GetValuesParser.swift
//  CircleProgressBar
//
//  Created by Rodrigo Gonzalez on 08/02/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import Foundation

/*
    Used to parse the values retrieved by GetValuesProvider and return Value objects
    @see GetValuesProvider
    @see Value
 */
protocol GetValuesParser {
    func parseValue(value: [String:Any]) -> Value
}

// we will only parse the values that we're going to use.
struct GetValuesParserImp: GetValuesParser {
    
    enum Keys: String {
        case accountIDVStatus, creditReportInfo, score, maxScoreValue, minScoreValue
    }
    
    func parseValue(value: [String:Any]) -> Value {
        let accountIDVStatus = value[Keys.accountIDVStatus.rawValue] as? String
        var score: Double = -1.0
        var maxScore: Double = -1.0
        var minScore: Double = -1.0
        
        if let creditReportInfo = value[Keys.creditReportInfo.rawValue] as? [String:Any] {
            score = creditReportInfo[Keys.score.rawValue] as? Double ?? score
            maxScore = creditReportInfo[Keys.maxScoreValue.rawValue] as? Double ?? maxScore
            minScore = creditReportInfo[Keys.minScoreValue.rawValue] as? Double ?? minScore
        }
        
        return Value(accountIDVStatus: accountIDVStatus, score: score, maxScoreValue: maxScore, minScoreValue: minScore)
    }
}

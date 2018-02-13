//
//  GetValuesPresenter.swift
//  CircleProgressBar
//
//  Created by Rodrigo Gonzalez on 08/02/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import Foundation

protocol GetValuesPresenterDelegate: NSObjectProtocol {
    func valueReady(value: VisualValue)
    func valueError(error: Error)
}
/*
    Used to retrieve Value objects using a GetValuesParser and a GetValuesProvider
 
    @param parser the GetValuesParser
    @param provider the GetValuesProvider
 
    @see GetValuesParser
    @see GetValuesProvider
 */
protocol GetValuesPresenter {
    var parser: GetValuesParser {get set}
    var provider: GetValuesProvider {get set}
    var delegate: GetValuesPresenterDelegate? {get set}
    func getValues()
}

struct GetValuesPresenterImp: GetValuesPresenter {
    var parser: GetValuesParser
    var provider: GetValuesProvider
    var delegate: GetValuesPresenterDelegate?
    

    func getValues() {
        provider.getValues { data, error in
            if let error = error {
                self.delegate?.valueError(error: error)
            }
            
            if let data = data {
                let value = self.parser.parseValue(value: data)
                let visualValue = self.createVisualValue(value: value)
                DispatchQueue.main.async {
                    self.delegate?.valueReady(value: visualValue)
                }
            }
        }
    }
    
    func createVisualValue(value: Value) -> VisualValue {
        let title = Title(text: NSLocalizedString("main.credit.score",  comment: ""),
                          value: "\n \(value.score) \n",
                          text2: NSLocalizedString("main.credit.out", comment: ""),
                          value2: " \(value.maxScoreValue)"
                         )
        
        return VisualValue(score: value.score, maxScoreValue: value.maxScoreValue, minScoreValue: value.minScoreValue, status: VisualValue.statusFromString(string: value.accountIDVStatus), title: title)
    }
}

struct Title {
    let text: String
    let value: String
    let text2: String
    let value2 : String
}

struct VisualValue {
    let score: Double
    let maxScoreValue: Double
    let minScoreValue: Double
    let status: Status
    let title: Title
    
    
    enum Status {
        case pass
        case fail
    }
    
    static func statusFromString(string: String?) -> Status {
        return (string?.caseInsensitiveCompare("PASS") == ComparisonResult.orderedSame) ? .pass : .fail
    }
}


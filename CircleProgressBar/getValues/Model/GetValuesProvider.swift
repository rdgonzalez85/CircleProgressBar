//
//  GetValuesProvider.swift
//  CircleProgressBar
//
//  Created by Rodrigo Gonzalez on 08/02/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import Foundation

typealias GetValuesProviderResponse = (Dictionary<String,Any>?, Error?) -> Void

enum GetValuesProviderError: Error {
    case missingURL
    case connectionError(error:Error)
    case incorrectFormat
}

/*
    Main interface used for retrieving information
*/
protocol GetValuesProvider {
    /*
        Async method to retrieve values
        @param completionHandler the async response
     */
    func getValues(completionHandler: @escaping GetValuesProviderResponse)
}

struct GetValuesNetworkProvider: GetValuesProvider {
    let endpointURL: String
    
    func getValues(completionHandler: @escaping GetValuesProviderResponse) {
        guard let url = URL(string: endpointURL) else {
            completionHandler(nil, GetValuesProviderError.missingURL)
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(nil, GetValuesProviderError.connectionError(error:error))
            } else {
                if let data = data {
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                        completionHandler(jsonData, nil)
                    } catch {
                        completionHandler(nil, GetValuesProviderError.incorrectFormat)
                    }
                }
            }
        }.resume()
    }
}

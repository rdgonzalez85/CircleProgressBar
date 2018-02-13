//
//  GetValuesWireframe.swift
//  CircleProgressBar
//
//  Created by Rodrigo Gonzalez on 09/02/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import UIKit

struct GetValuesWireframe {

    static let storyboardName = "Main"
    static let viewControllerIdentifier = "GetValuesViewController"
    
    static func getValuesViewController() -> UIViewController {
        if let viewController = UIStoryboard.storyboard(name: storyboardName, viewController: viewControllerIdentifier) as? GetValuesViewController, let endpointURL = self.getURL() {
            
            let provider = GetValuesNetworkProvider(endpointURL: endpointURL)
            
            let parser = GetValuesParserImp()
            
            let presenter = GetValuesPresenterImp(parser: parser, provider: provider, delegate: viewController)
            
            viewController.presenter = presenter
            
            return viewController
        }
        return UIViewController()
    }
    
    // get the url from the Info.plist file
    static let fileName = "Info"
    static let fileExtension = "plist"
    static let endpointURLKey = "endpointURL"
    
    static func getURL() -> String? {
        if let fileUrl = Bundle.main.url(forResource: fileName, withExtension: fileExtension),
            let data = try? Data(contentsOf: fileUrl) {
            if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] { 
                return result?[endpointURLKey] as? String
            }
        }
        return nil
    }
}

// extension to load UIViewControllers from UIStoryboard
extension UIStoryboard {
    class func storyboard(name: String, viewController: String) -> UIViewController {
        return UIStoryboard.init(name: name, bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
}

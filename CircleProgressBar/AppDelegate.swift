//
//  AppDelegate.swift
//  CircleProgressBar
//
//  Created by Rodrigo Gonzalez on 08/02/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        let mainVC = GetValuesWireframe.getValuesViewController()
        
        let navigationController = UINavigationController(rootViewController: mainVC)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}


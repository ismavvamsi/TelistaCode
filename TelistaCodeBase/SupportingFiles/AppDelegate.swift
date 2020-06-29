//
//  AppDelegate.swift
//  TelistaCodeBase
//
//  Created by Kameswararao on 25/06/20.
//  Copyright © 2020 VamsiKrishna. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = FactsViewController()
        window?.makeKeyAndVisible()
        
        return true
        
    }
}


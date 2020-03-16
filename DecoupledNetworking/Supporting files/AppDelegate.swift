//
//  AppDelegate.swift
//  DecoupledNetworking
//
//  Created by Alex on 17/01/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import UIKit
import SimpleCachedNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let policy = MaxSizeCleanupPolicy()
        try? URLSession.cached.cleanup(using: policy)
        
        return true
    }
}

// URLSession cache
extension AppDelegate {

}

//
//  AppDelegate.swift
//  NikhilYeola_Demo
//
//  Created by Nikhil Yeola on 24/11/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationViewController = UINavigationController(rootViewController: CryptoListViewController())
        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }


}


//
//  AppDelegate.swift
//  CryptoWallet
//
//  Created by Илья Слепцов on 26.04.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        let window = UIWindow()
        window.rootViewController = AuthViewController()
        window.makeKeyAndVisible()
        
        self.window = window
      
        return true
    }
}


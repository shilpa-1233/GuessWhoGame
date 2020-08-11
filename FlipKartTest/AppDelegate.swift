//
//  AppDelegate.swift
//  FlipKartTest
//
//  Created by Shilpa Garg on 04/07/20.
//  Copyright © 2020 Shilpa Garg. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.window = UIWindow.init()
        let startViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StartViewController") as! StartViewController
        appDelegate.window?.rootViewController = UINavigationController.init(rootViewController: startViewController)
        appDelegate.window?.makeKeyAndVisible()
        return true
    }
    
    
}


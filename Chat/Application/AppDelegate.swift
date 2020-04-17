//
//  AppDelegate.swift
//  Chat
//
//  Created by Alessandro Schioppetti on 02/04/2020.
//  Copyright © 2020 Codermine Srl. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let controller = WelcomeViewController(nibName: "WelcomeViewController", bundle: nil)
        let nav = UINavigationController(rootViewController: controller)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }


}


//
//  AppDelegate.swift
//  IOSUnLockGesturesView
//
//  Created by 乔晓松 on 2018/3/19.
//  Copyright © 2018年 coolspan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        initMainViewController()
        
        return true
    }
    
}

// MARK: - private methods
private extension AppDelegate {
    
    func initMainViewController() -> Void {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let navigationVC = UINavigationController.init(rootViewController: HomeViewController())
        navigationVC.setNavigationBarHidden(true, animated: true)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }
}


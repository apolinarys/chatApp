//
//  AppDelegate.swift
//  MessageApp
//
//  Created by Macbook on 22.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let logger = Logger()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        logger.logging(funcName: "didFinishLaunchingWithOptions")
        return true
    }
   
    func applicationDidBecomeActive(_ application: UIApplication) {
        logger.logging(funcName: "applicationDidBecomeActive")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        logger.logging(funcName: "applicationWillResignActive")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        logger.logging(funcName: "applicationWillEnterForeground")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        logger.logging(funcName: "applicationDidEnterBackground")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        logger.logging(funcName: "applicationWillTerminate")
    }

}


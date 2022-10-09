//
//  AppDelegate.swift
//  MessageApp
//
//  Created by Macbook on 22.09.2022.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ConversationListViewController()) 
        window?.makeKeyAndVisible()
        
        return true
    }
}


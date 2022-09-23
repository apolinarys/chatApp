//
//  Logger.swift
//  MessageApp
//
//  Created by Macbook on 23.09.2022.
//

import Foundation

struct Logger {
    
    private let choice = true
    
    func logging(funcName: String) {
        if choice == true{
            switch funcName {
            case "didFinishLaunchingWithOptions":
                print("Application moved from not running to inactive: ", funcName)
            case "viewWillAppear", "viewWillLayoutSubviews", "viewDidLayoutSubviews", "viewDidLoad":
                print("Application stayed inactive: ", funcName)
            case "applicationDidBecomeActive":
                print("Application moved from inactive to active: ", funcName)
            case "viewDidAppear", "applicationWillResignActive", "applicationWillEnterBackground", "viewWillDisappear", "viewDidDisappear":
                print("Application stayed active: ", funcName)
            case "applicationDidEnterBackground":
                print("Application moved from active to background: ", funcName)
            case "applicationWillTerminate":
                print("Application moved from background to suspended: ", funcName)
            default:
                print("Function name wasn't recognized")
            }
        }
    }
}

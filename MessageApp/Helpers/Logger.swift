//
//  Logger.swift
//  MessageApp
//
//  Created by Macbook on 25.09.2022.
//

import Foundation
import UIKit

struct Logger {
    
    static let choice = false
    
    static func printFrame(subject: UIButton) {
        if choice {
            print(subject.frame)
        }
    }
}

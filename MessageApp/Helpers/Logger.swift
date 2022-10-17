//
//  Logger.swift
//  MessageApp
//
//  Created by Macbook on 25.09.2022.
//

import Foundation
import UIKit

struct Logger {
    static let shared = Logger()
    
    func message(_ message: String) {
        #if DEBUG
        print(message)
        #endif
    }
}

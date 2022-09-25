//
//  Logger.swift
//  MessageApp
//
//  Created by Macbook on 25.09.2022.
//

import Foundation

struct Logger {
    private let profileView = ProfileView()
    private let choice = true
    
    func printFrame() {
        if choice {
            print(profileView.editButton.frame)
        }
    }
}

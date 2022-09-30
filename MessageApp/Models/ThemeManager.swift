//
//  Theme.swift
//  MessageApp
//
//  Created by Macbook on 29.09.2022.
//

import UIKit

enum Theme: Int {
    case Classic, Day, Night
    
    var mainColor: UIColor {
        switch self {
        case .Classic:
            return UIColor.white
        case .Day:
            return UIColor.white
        case .Night:
            return UIColor(red: 6/255, green: 6/255, blue: 6/255, alpha: 1)
        }
    }
    
    var incomingMessageColor: UIColor {
        switch self {
        case .Classic:
            return UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1)
        case .Day:
            return UIColor(red: 236/255, green: 236/255, blue: 238/255, alpha: 1)
        case .Night:
            return UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1)
        }
    }
    
    var outgoingMessageColor: UIColor {
        switch self {
        case .Classic:
            return UIColor(red: 220/255, green: 248/255, blue: 197/255, alpha: 1)
        case .Day:
            return UIColor(red: 70/255, green: 135/255, blue: 249/255, alpha: 1)
        case .Night:
            return UIColor(red: 92/255, green: 92/255, blue: 92/255, alpha: 1)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .Classic:
            return UIColor.black
        case .Day:
            return UIColor.black
        case .Night:
            return UIColor.white
        }
    }
}

struct ThemeManager: ThemesPickerDelegate {
    
    static let SelectedThemeKey = "SelectedTheme"
    
    func applyTheme(theme: Theme) {
        UserDefaults.standard.setValue(theme.rawValue, forKey: ThemeManager.SelectedThemeKey)
    }
    
    init() {
        ThemesView.themeDelegate = self
    }
    
    static func currentTheme() -> Theme {
        let storedTheme = UserDefaults.standard.integer(forKey: SelectedThemeKey)
            return Theme(rawValue: storedTheme) ?? .Classic
    }
    
    static func applyTheme(theme: Theme) {
        UserDefaults.standard.setValue(theme.rawValue, forKey: SelectedThemeKey)
    }
}

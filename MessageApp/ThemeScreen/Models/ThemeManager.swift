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
        case Theme.Classic:
            return UIColor.white
        case Theme.Day:
            return UIColor.white
        case Theme.Night:
            return UIColor(red: 6/255, green: 6/255, blue: 6/255, alpha: 1)
        }
    }
    
    var incomingMessageColor: UIColor {
        switch self {
        case Theme.Classic:
            return UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1)
        case Theme.Day:
            return UIColor(red: 236/255, green: 236/255, blue: 238/255, alpha: 1)
        case Theme.Night:
            return UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1)
        }
    }
    
    var outgoingMessageColor: UIColor {
        switch self {
        case Theme.Classic:
            return UIColor(red: 220/255, green: 248/255, blue: 197/255, alpha: 1)
        case Theme.Day:
            return UIColor(red: 70/255, green: 135/255, blue: 249/255, alpha: 1)
        case Theme.Night:
            return UIColor(red: 92/255, green: 92/255, blue: 92/255, alpha: 1)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case Theme.Classic:
            return UIColor.black
        case Theme.Day:
            return UIColor.black
        case Theme.Night:
            return UIColor.white
        }
    }
}

enum ButtonTheme: Int {
    case Classic, Day, Night
    
    var backgroundColor: UIColor {
        switch self {
        case ButtonTheme.Classic:
            return UIColor.white
        case ButtonTheme.Day:
            return UIColor.white
        case ButtonTheme.Night:
            return UIColor(red: 6/255, green: 6/255, blue: 6/255, alpha: 1)
        }
    }
    
    var firstMessageBubbleColor: UIColor {
        switch self {
        case ButtonTheme.Classic:
            return UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1)
        case ButtonTheme.Day:
            return UIColor(red: 236/255, green: 236/255, blue: 238/255, alpha: 1)
        case ButtonTheme.Night:
            return UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1)
        }
    }
    
    var secondMessageBubbleColor: UIColor {
        switch self {
        case ButtonTheme.Classic:
            return UIColor(red: 220/255, green: 248/255, blue: 197/255, alpha: 1)
        case ButtonTheme.Day:
            return UIColor(red: 70/255, green: 135/255, blue: 249/255, alpha: 1)
        case ButtonTheme.Night:
            return UIColor(red: 92/255, green: 92/255, blue: 92/255, alpha: 1)
        }
    }
}

final class ThemeManager: ThemesPickerDelegate {
    
    static let shared = ThemeManager()
    
    private init() {
    }
    
    static let SelectedThemeKey = "SelectedTheme"
    
    static func currentTheme() -> Theme {
        let storedTheme = UserDefaults.standard.integer(forKey: SelectedThemeKey)
            return Theme(rawValue: storedTheme) ?? Theme.Classic
    }
    
     func applyTheme(theme: Theme) {
         UserDefaults.standard.setValue(theme.rawValue, forKey: ThemeManager.SelectedThemeKey)
    }
}

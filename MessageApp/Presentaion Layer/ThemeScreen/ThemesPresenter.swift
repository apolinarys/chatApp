//
//  ThemesPresenter.swift
//  MessageApp
//
//  Created by Macbook on 14.10.2022.
//

import UIKit

protocol IThemePresenter {
    func cancelPressed()
    func backPressed()
}

struct ThemesPresenter: IThemePresenter {
    
    let router: IRouter
    let themeManager: ThemeManager
    
    func cancelPressed() {
        router.popViewController()
    }
    
    func backPressed() {
        router.popViewController()
        guard let theme = ThemesViewController.theme else {return}
        themeManager.applyTheme(theme: theme)
    }
}

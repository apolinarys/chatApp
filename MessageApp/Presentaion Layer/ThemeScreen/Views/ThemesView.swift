//
//  ThemesView.swift
//  MessageApp
//
//  Created by Macbook on 28.09.2022.
//

import UIKit

final class ThemesView: UIStackView {
    
    private let borderColor = CGColor(red: 45/255, green: 113/255, blue: 239/255, alpha: 1)
    
    private lazy var classicView: ThemeButton = {
        let view = ThemeButton(frame: CGRect.zero, theme: ButtonTheme.Classic, name: "Classic", action: classicTapped)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dayView: ThemeButton = {
        let view = ThemeButton(frame: CGRect.zero, theme: ButtonTheme.Day, name: "Day", action: dayTapped)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nightView: ThemeButton = {
        let view = ThemeButton(frame: CGRect.zero, theme: ButtonTheme.Night, name: "Night", action: nightTapped)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = NSLayoutConstraint.Axis.vertical
        self.alignment = UIStackView.Alignment.fill
        self.distribution = UIStackView.Distribution.fillEqually
        addSubviews()
        setupBorder()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Buttons Actions

extension ThemesView {
    
    private func classicTapped() {
        classicView.button.layer.borderWidth = 4
        
        dayView.button.layer.borderWidth = 0
        nightView.button.layer.borderWidth = 0
        
        ThemesViewController.theme = Theme.Classic
    }
    
    private func dayTapped() {
        dayView.button.layer.borderWidth = 4
        
        classicView.button.layer.borderWidth = 0
        nightView.button.layer.borderWidth = 0
        
        ThemesViewController.theme = Theme.Day
    }
    
    private func nightTapped() {
        nightView.button.layer.borderWidth = 4
        
        classicView.button.layer.borderWidth = 0
        dayView.button.layer.borderWidth = 0
        
        ThemesViewController.theme = Theme.Night
    }
}

//MARK: - Setting up view

extension ThemesView {
    
    private func setupBorder() {
        let theme = ThemeManager.currentTheme()
        switch theme {
        case Theme.Classic:
            classicView.button.layer.borderWidth = 4
        case Theme.Day:
            dayView.button.layer.borderWidth = 4
        case Theme.Night:
            nightView.button.layer.borderWidth = 4
        }
    }
    
    private func addSubviews() {
        self.addArrangedSubview(classicView)
        self.addArrangedSubview(dayView)
        self.addArrangedSubview(nightView)
    }
}

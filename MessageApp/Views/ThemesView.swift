//
//  ThemesView.swift
//  MessageApp
//
//  Created by Macbook on 28.09.2022.
//

import UIKit

protocol ThemeViewDelegate {
    func updateTheme()
}

protocol ThemesPickerDelegate {
    func applyTheme(theme: Theme)
}

final class ThemesView: UIStackView {
    
    static var delegate: ThemeViewDelegate?
    
    static var themeDelegate: ThemesPickerDelegate? // retain cycle may have appeared if this property wasn't static and we would create a link to this object in ThemeManager
    
    let themeManager = ThemeManager()
    
    private let borderColor = CGColor(red: 45/255, green: 113/255, blue: 239/255, alpha: 1)
    
    private lazy var classicView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var classicButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(classicTapped), for: .touchUpInside)
        button.layer.borderColor = borderColor
        return button
    }()
    
    private lazy var firstMessageBubble: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(classicTapped)))
        return view
    }()
    
    private lazy var secondMessageBubble: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor(red: 220/255, green: 248/255, blue: 197/255, alpha: 1)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(classicTapped)))
        return view
    }()
    
    private lazy var classicLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Classic"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        label.contentMode = .center
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(classicTapped)))
        return label
    }()
    
    private lazy var dayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(dayTapped), for: .touchUpInside)
        button.layer.borderColor = borderColor
        return button
    }()
    
    private lazy var thirdMessageBubble: UIView = {
        let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.layer.cornerRadius = 15
         view.backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 238/255, alpha: 1)
         view.isUserInteractionEnabled = true
         view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dayTapped)))
         return view
    }()
    
    private lazy var fourthMessageBubble: UIView = {
        let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.layer.cornerRadius = 15
         view.backgroundColor = UIColor(red: 70/255, green: 135/255, blue: 249/255, alpha: 1)
         view.isUserInteractionEnabled = true
         view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dayTapped)))
         return view
    }()
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Day"
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        label.contentMode = .center
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dayTapped)))
        return label
    }()
    
    private lazy var nightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red: 6/255, green: 6/255, blue: 6/255, alpha: 1)
        button.addTarget(self, action: #selector(nightTapped), for: .touchUpInside)
        button.layer.borderColor = borderColor
        return button
    }()
    
    private lazy var fifthMessageBubble: UIView = {
        let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.layer.cornerRadius = 15
         view.backgroundColor = UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1)
         view.isUserInteractionEnabled = true
         view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nightTapped)))
         return view
    }()
    
    private lazy var sixthMessageBubble: UIView = {
        let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.layer.cornerRadius = 15
         view.backgroundColor = UIColor(red: 92/255, green: 92/255, blue: 92/255, alpha: 1)
         view.isUserInteractionEnabled = true
         view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nightTapped)))
         return view
    }()
    
    private lazy var nightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Night"
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        label.contentMode = .center
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nightTapped)))
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillEqually
        addSubviews()
        setupConstraints()
        setupBorder()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func classicTapped() {
        classicButton.layer.borderWidth = 4
        
        dayButton.layer.borderWidth = 0
        nightButton.layer.borderWidth = 0
        
        
        ThemesView.themeDelegate?.applyTheme(theme: Theme.Classic)
//        ThemeManager.applyTheme(theme: Theme.Classic)
        ThemesView.delegate?.updateTheme()
    }
    
    @objc private func dayTapped() {
        dayButton.layer.borderWidth = 4
        
        classicButton.layer.borderWidth = 0
        nightButton.layer.borderWidth = 0
        
        ThemesView.themeDelegate?.applyTheme(theme: Theme.Day)
//        ThemeManager.applyTheme(theme: Theme.Day)
        ThemesView.delegate?.updateTheme()
    }
    
    @objc private func nightTapped() {
        nightButton.layer.borderWidth = 4
        
        classicButton.layer.borderWidth = 0
        dayButton.layer.borderWidth = 0
        
        ThemesView.themeDelegate?.applyTheme(theme: Theme.Night)
//        ThemeManager.applyTheme(theme: Theme.Night)
        ThemesView.delegate?.updateTheme()
    }
    
    private func setupBorder() {
        let theme = ThemeManager.currentTheme()
        switch theme {
        case .Classic:
            classicButton.layer.borderWidth = 4
        case .Day:
            dayButton.layer.borderWidth = 4
        case .Night:
            nightButton.layer.borderWidth = 4
        }
    }
    
    private func addSubviews() {
        self.addArrangedSubview(classicView)
        classicView.addSubview(classicButton)
        classicButton.addSubview(firstMessageBubble)
        classicButton.addSubview(secondMessageBubble)
        classicView.addSubview(classicLabel)
        
        self.addArrangedSubview(dayView)
        dayView.addSubview(dayButton)
        dayButton.addSubview(thirdMessageBubble)
        dayButton.addSubview(fourthMessageBubble)
        dayView.addSubview(dayLabel)
        
        self.addArrangedSubview(nightView)
        nightView.addSubview(nightButton)
        nightButton.addSubview(fifthMessageBubble)
        nightButton.addSubview(sixthMessageBubble)
        nightView.addSubview(nightLabel)
    }
    
    private func setupConstraints() {
        
        let buttonHight: CGFloat = 80
        
        NSLayoutConstraint.activate([
            classicButton.centerYAnchor.constraint(equalTo: classicView.centerYAnchor, constant: -10),
            classicButton.leadingAnchor.constraint(equalTo: classicView.leadingAnchor, constant: 10),
            classicButton.trailingAnchor.constraint(equalTo: classicView.trailingAnchor, constant: -10),
            classicButton.heightAnchor.constraint(equalToConstant: buttonHight),
            
            firstMessageBubble.topAnchor.constraint(equalTo: classicButton.topAnchor, constant: 8),
            firstMessageBubble.heightAnchor.constraint(equalTo: classicButton.heightAnchor, multiplier: 0.5),
            firstMessageBubble.leadingAnchor.constraint(equalTo: classicButton.leadingAnchor, constant: 20),
            firstMessageBubble.trailingAnchor.constraint(equalTo: classicButton.centerXAnchor, constant: -2),
            
            secondMessageBubble.bottomAnchor.constraint(equalTo: classicButton.bottomAnchor, constant: -8),
            secondMessageBubble.heightAnchor.constraint(equalTo: classicButton.heightAnchor, multiplier: 0.5),
            secondMessageBubble.leadingAnchor.constraint(equalTo: classicButton.centerXAnchor, constant: 2),
            secondMessageBubble.trailingAnchor.constraint(equalTo: classicButton.trailingAnchor, constant: -20),
            
            classicLabel.topAnchor.constraint(equalTo: classicButton.bottomAnchor, constant: 15),
            classicLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            dayButton.centerYAnchor.constraint(equalTo: dayView.centerYAnchor, constant: -10),
            dayButton.leadingAnchor.constraint(equalTo: dayView.leadingAnchor, constant: 10),
            dayButton.trailingAnchor.constraint(equalTo: dayView.trailingAnchor, constant: -10),
            dayButton.heightAnchor.constraint(equalToConstant: buttonHight),

            thirdMessageBubble.topAnchor.constraint(equalTo: dayButton.topAnchor, constant: 8),
            thirdMessageBubble.heightAnchor.constraint(equalTo: dayButton.heightAnchor, multiplier: 0.5),
            thirdMessageBubble.leadingAnchor.constraint(equalTo: dayButton.leadingAnchor, constant: 20),
            thirdMessageBubble.trailingAnchor.constraint(equalTo: dayButton.centerXAnchor, constant: -2),

            fourthMessageBubble.bottomAnchor.constraint(equalTo: dayButton.bottomAnchor, constant: -8),
            fourthMessageBubble.heightAnchor.constraint(equalTo: dayButton.heightAnchor, multiplier: 0.5),
            fourthMessageBubble.leadingAnchor.constraint(equalTo: dayButton.centerXAnchor, constant: 2),
            fourthMessageBubble.trailingAnchor.constraint(equalTo: dayButton.trailingAnchor, constant: -20),
            
            dayLabel.topAnchor.constraint(equalTo: dayButton.bottomAnchor, constant: 15),
            dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            nightButton.centerYAnchor.constraint(equalTo: nightView.centerYAnchor, constant: -10),
            nightButton.leadingAnchor.constraint(equalTo: nightView.leadingAnchor, constant: 10),
            nightButton.trailingAnchor.constraint(equalTo: nightView.trailingAnchor, constant: -10),
            nightButton.heightAnchor.constraint(equalToConstant: buttonHight),

            fifthMessageBubble.topAnchor.constraint(equalTo: nightButton.topAnchor, constant: 8),
            fifthMessageBubble.heightAnchor.constraint(equalTo: nightButton.heightAnchor, multiplier: 0.5),
            fifthMessageBubble.leadingAnchor.constraint(equalTo: nightButton.leadingAnchor, constant: 20),
            fifthMessageBubble.trailingAnchor.constraint(equalTo: nightButton.centerXAnchor, constant: -2),

            sixthMessageBubble.bottomAnchor.constraint(equalTo: nightButton.bottomAnchor, constant: -8),
            sixthMessageBubble.heightAnchor.constraint(equalTo: nightButton.heightAnchor, multiplier: 0.5),
            sixthMessageBubble.leadingAnchor.constraint(equalTo: nightButton.centerXAnchor, constant: 2),
            sixthMessageBubble.trailingAnchor.constraint(equalTo: nightButton.trailingAnchor, constant: -20),
            
            nightLabel.topAnchor.constraint(equalTo: nightButton.bottomAnchor, constant: 15),
            nightLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}

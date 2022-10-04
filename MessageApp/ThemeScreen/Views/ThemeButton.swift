//
//  ThemeButton.swift
//  MessageApp
//
//  Created by Macbook on 04.10.2022.
//

import UIKit

final class ThemeButton: UIView {
    
    private var action: (() -> Void)?
    private var theme: ButtonTheme?
    private var name: String?
    
    private let borderColor = CGColor(red: 45/255, green: 113/255, blue: 239/255, alpha: 1)
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = theme?.backgroundColor
        button.layer.borderColor = borderColor
        button.addTarget(self, action: #selector(addAction), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private lazy var firstMessageBubble: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = theme?.firstMessageBubbleColor
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addAction)))
        return view
    }()
    
    private lazy var secondMessageBubble: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = theme?.secondMessageBubbleColor
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addAction)))
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = name
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.heavy)
        label.contentMode = UIView.ContentMode.center
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addAction)))
        return label
    }()
    
    init(frame: CGRect, theme: ButtonTheme, name: String, action: @escaping () -> Void) {
        super.init(frame: frame)
        self.theme = theme
        self.name = name
        self.action = action
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(button)
        addSubview(firstMessageBubble)
        addSubview(secondMessageBubble)
        addSubview(label)
    }
    
    @objc private func addAction() {
        guard let action = action else {
            return
        }
        action()
    }
    
    private func setupConstraints() {
        
        let buttonHight: CGFloat = 80
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            button.heightAnchor.constraint(equalToConstant: buttonHight),
            
            firstMessageBubble.topAnchor.constraint(equalTo: button.topAnchor, constant: 8),
            firstMessageBubble.heightAnchor.constraint(equalTo: button.heightAnchor, multiplier: 0.5),
            firstMessageBubble.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 20),
            firstMessageBubble.trailingAnchor.constraint(equalTo: button.centerXAnchor, constant: -2),
            
            secondMessageBubble.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -8),
            secondMessageBubble.heightAnchor.constraint(equalTo: button.heightAnchor, multiplier: 0.5),
            secondMessageBubble.leadingAnchor.constraint(equalTo: button.centerXAnchor, constant: 2),
            secondMessageBubble.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -20),
            
            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 15),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}

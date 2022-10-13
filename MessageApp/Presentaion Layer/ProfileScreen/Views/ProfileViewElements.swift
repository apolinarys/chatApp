//
//  ProfileButton.swift
//  MessageApp
//
//  Created by Macbook on 11.10.2022.
//

import UIKit

struct ProfileViewElements {
    let theme: Theme
    
    func createButton(text: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = theme.incomingMessageColor
        button.setTitle(text, for: .normal)
        button.setTitleColor(theme.textColor, for: .normal)
        button.layer.cornerRadius = 10
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func createTextField(text: String, delegate: UITextFieldDelegate) -> UITextField {
        let textField = UITextField()
        textField.placeholder = text
        textField.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        textField.isUserInteractionEnabled = false
        textField.textColor = theme.textColor
        textField.delegate = delegate
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}

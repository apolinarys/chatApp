//
//  ProfileView.swift
//  MessageApp
//
//  Created by Macbook on 23.09.2022.
//

import UIKit

final class ProfileView: UIView, UITextFieldDelegate {
    
    private let theme = ThemeManager.currentTheme()
    private let buttonHeight: CGFloat = 50

    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.tintColor = .darkGray
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var addPhotoView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 63/255, green: 120/255, blue: 240/255, alpha: 1)
        view.layer.cornerRadius = 40
        view.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(addProfilePicture))
        view.addGestureRecognizer(gesture)
        return view
    }()
    
    private lazy var photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "camera.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = theme.incomingMessageColor
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(theme.textColor, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(edit), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private lazy var nameTextField: UITextField = {
       let field = UITextField()
        field.placeholder = "Name"
        field.textAlignment = .center
        field.adjustsFontSizeToFitWidth = true
        field.delegate = self
        field.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.heavy)
        field.isUserInteractionEnabled = false
        field.autocapitalizationType = .words
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var bioTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "bio"
        field.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        field.delegate = self
        field.isUserInteractionEnabled = false
        field.translatesAutoresizingMaskIntoConstraints = false
         return field
    }()
    
    private lazy var locationTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Location"
        field.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        field.delegate = self
        field.isUserInteractionEnabled = false
        field.translatesAutoresizingMaskIntoConstraints = false
         return field
    }()
    
    private lazy var cancelButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = theme.incomingMessageColor
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(theme.textColor, for: .normal)
        button.layer.cornerRadius = 10
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private lazy var saveGCDButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = theme.incomingMessageColor
        button.setTitle("Save GCD", for: .normal)
        button.setTitleColor(theme.textColor, for: .normal)
        button.layer.cornerRadius = 10
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private lazy var saveOperationsButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = theme.incomingMessageColor
        button.setTitle("Save Operations", for: .normal)
        button.setTitleColor(theme.textColor, for: .normal)
        button.layer.cornerRadius = 10
        button.isUserInteractionEnabled = false
        return button
    }()
    
    weak var vc: UIViewController?
    
    init(frame: CGRect, vc: UIViewController) {
        self.vc = vc
        super.init(frame: .zero)
        self.backgroundColor = theme.mainColor
        addSubviews()
        setupConstraints()
        hideButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            profileImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            
            addPhotoView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            addPhotoView.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor),
            addPhotoView.heightAnchor.constraint(equalToConstant: addPhotoView.layer.cornerRadius * 2),
            addPhotoView.widthAnchor.constraint(equalTo: addPhotoView.heightAnchor),
            
            photoImageView.centerXAnchor.constraint(equalTo: addPhotoView.centerXAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: addPhotoView.centerYAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 50),
            photoImageView.widthAnchor.constraint(equalTo: photoImageView.heightAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            nameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            bioTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            bioTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            bioTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            locationTextField.topAnchor.constraint(equalTo: bioTextField.bottomAnchor, constant: 10),
            locationTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            locationTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            editButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60),
            editButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            editButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            saveGCDButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            saveGCDButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            saveGCDButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60),
            
            saveOperationsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            saveOperationsButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            saveOperationsButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60),
            
            cancelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            cancelButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            cancelButton.bottomAnchor.constraint(equalTo: saveGCDButton.topAnchor, constant: -8),
        ])
    }
    
    private func addSubviews() {
        addSubview(profileImageView)
        profileImageView.addSubview(addPhotoView)
        addPhotoView.addSubview(photoImageView)
        addSubview(editButton)
        addSubview(nameTextField)
        addSubview(bioTextField)
        addSubview(locationTextField)
        addSubview(saveGCDButton)
        addSubview(saveOperationsButton)
        addSubview(cancelButton)
    }
    
    @objc private func addProfilePicture() {
        guard let vc = vc else {return}
        PresentAlert.presentAlert(vc: vc)
    }
    
    @objc private func edit() {
        nameTextField.isUserInteractionEnabled = true
        nameTextField.becomeFirstResponder()
        bioTextField.isUserInteractionEnabled = true
        locationTextField.isUserInteractionEnabled = true
        cancelButton.isHidden = false
        saveGCDButton.isHidden = false
        saveOperationsButton.isHidden = false
        editButton.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            bioTextField.becomeFirstResponder()
        case bioTextField:
            locationTextField.becomeFirstResponder()
        default:
            textField.endEditing(true)
        }
        return true
    }
    
    private func hideButtons() {
        cancelButton.isHidden = true
        saveGCDButton.isHidden = true
        saveOperationsButton.isHidden = true
    }

}

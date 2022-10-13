//
//  ProfileView.swift
//  MessageApp
//
//  Created by Macbook on 23.09.2022.
//

import UIKit

protocol IProfileView: UIView {
    var theme: Theme? {get set}
    var vc: UIViewController? {get}
    var profileImageView: UIImageView {get}
    var editButton: UIButton {get}
    var saveButton: UIButton {get}
    var cancelButton: UIButton {get}
    var nameTextField: UITextField {get}
    var bioTextField: UITextField {get}
    var locationTextField: UITextField {get}
    
    func showActivityIndicator()
    func hideActivityIndicator()
    func hideSavingButtons()
    func updateData(data: ProfileData?)
}

final class ProfileView: UIView, UITextFieldDelegate, IProfileView {
    
    
    private let nameFile = "nameFile.txt"
    private let bioFile = "bioFile.txt"
    private let locationFile = "locationFile.txt"
    
    var theme: Theme?
    private let profileViewElements = ProfileViewElements(theme: ThemeManager.currentTheme())
    var profileData: ProfileData?
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.tintColor = .darkGray
        imageView.backgroundColor = UIColor.lightGray
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
        let gesture = UITapGestureRecognizer(target: self, action: #selector(addProfilePicturePressed))
        view.addGestureRecognizer(gesture)
        return view
    }()
    
    private lazy var photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "camera.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor.white
        return imageView
    }()
    
    lazy var editButton = profileViewElements.createButton(text: "edit")
    
    lazy var nameTextField = profileViewElements.createTextField(text: "Name", delegate: self)
    
    lazy var bioTextField = profileViewElements.createTextField(text: "bio", delegate: self)
    
    lazy var locationTextField = profileViewElements.createTextField(text: "Location", delegate: self)
    
    lazy var saveButton = profileViewElements.createButton(text: "Save")
    
    lazy var cancelButton = profileViewElements.createButton(text: "Cancel")
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var vc: UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = theme?.mainColor
        addSubviews()
        setupConstraints()
        hideSavingButtons()
        createDismissGesture()
        createButtonsActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createButtonsActions() {
        editButton.isUserInteractionEnabled = true
        editButton.addTarget(self, action: #selector(editPressed), for: UIControl.Event.touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelPressed), for: UIControl.Event.touchUpInside)
    }
    
    private func setupConstraints() {
        let cancelButtonConstraints = createConstraintsForButtons(button: cancelButton, anchor: self.trailingAnchor)
        let saveButtonConstraints = createConstraintsForButtons(button: saveButton, anchor: self.leadingAnchor)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 60),
            profileImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.6),
            profileImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
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
            nameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            bioTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            bioTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            bioTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            bioTextField.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            locationTextField.topAnchor.constraint(equalTo: bioTextField.bottomAnchor, constant: 10),
            locationTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            locationTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            editButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            editButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            editButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.08),
            
            activityIndicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            activityIndicatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            activityIndicatorView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -20)
        ] + saveButtonConstraints + cancelButtonConstraints)
    }
    
    private func createConstraintsForButtons(button: UIButton, anchor: NSLayoutXAxisAnchor) -> [NSLayoutConstraint] {
        return [
            button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.46),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            button.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.08),
            anchor == self.trailingAnchor ? button.trailingAnchor.constraint(equalTo: anchor, constant: -8) : button.leadingAnchor.constraint(equalTo: anchor, constant: 8)
        ]
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(profileImageView)
        profileImageView.addSubview(addPhotoView)
        addPhotoView.addSubview(photoImageView)
        addSubview(editButton)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(bioTextField)
        scrollView.addSubview(locationTextField)
        addSubview(saveButton)
        addSubview(cancelButton)
        addSubview(activityIndicatorView)
    }
    
    private func createDismissGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(gesture)
    }
    
    @objc private func dismissKeyboard() {
        nameTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
        bioTextField.resignFirstResponder()
    }
    
    @objc private func addProfilePicturePressed() {
        showSavingButtons()
        guard let vc = vc else {return}
        let allertControllerPresenter = AllertControllerPresenter()
        allertControllerPresenter.presentAlert(vc: vc)
    }
    
    func updateData(data: ProfileData?) {
        self.showActivityIndicator()
        self.profileData = data
        self.nameTextField.text = data?.name
        self.locationTextField.text = data?.location
        self.bioTextField.text = data?.bio
        self.hideActivityIndicator()
    }
    
    func showActivityIndicator() {
        self.activityIndicatorView.isHidden = false
        self.activityIndicatorView.startAnimating()
    }
    
    func hideActivityIndicator() {
        self.activityIndicatorView.stopAnimating()
        self.activityIndicatorView.isHidden = true
    }
    
    @objc private func editPressed() {
        showSavingButtons()
        nameTextField.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        var textField = nameTextField
        if bioTextField.isFirstResponder {
            textField = bioTextField
        } else if locationTextField.isFirstResponder {
            textField = locationTextField
        }
        let userInfo = notification.userInfo!
        let keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let inset = textField.frame.maxY - keyboardFrame.size.height
        scrollView.contentOffset = CGPoint(x: 0, y: inset)
        
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    @objc func cancelPressed() {
        hideSavingButtons()
        
        nameTextField.text = profileData?.name
        bioTextField.text = profileData?.bio
        locationTextField.text = profileData?.location
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if nameTextField.text != profileData?.name ||
            bioTextField.text != profileData?.bio ||
            locationTextField.text != profileData?.location
        {
            saveButton.isUserInteractionEnabled = true
            cancelButton.isUserInteractionEnabled = true
        }
    }
    
    private func showSavingButtons() {
        editButton.isHidden = true
        cancelButton.isHidden = false
        saveButton.isHidden = false
        cancelButton.isHidden = false
        nameTextField.isUserInteractionEnabled = true
        bioTextField.isUserInteractionEnabled = true
        locationTextField.isUserInteractionEnabled = true
    }
    
    func hideSavingButtons() {
        cancelButton.isHidden = true
        saveButton.isHidden = true
        cancelButton.isHidden = true
        editButton.isHidden = false
        nameTextField.isUserInteractionEnabled = false
        bioTextField.isUserInteractionEnabled = false
        locationTextField.isUserInteractionEnabled = false
    }

}

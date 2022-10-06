//
//  ProfileView.swift
//  MessageApp
//
//  Created by Macbook on 23.09.2022.
//

import UIKit

final class ProfileView: UIView, UITextFieldDelegate {
    
    private let nameFile = "nameFile.txt"
    private let bioFile = "bioFile.txt"
    private let locationFile = "locationFile.txt"
    private let queue = DispatchQueue(label: "ru.apolinarys.serial", qos: DispatchQoS.background)
    private let dataManager = DataManager()
    
    private let theme = ThemeManager.currentTheme()
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
        let gesture = UITapGestureRecognizer(target: self, action: #selector(addProfilePicture))
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
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = theme.incomingMessageColor
        button.setTitle("Edit", for: UIControl.State.normal)
        button.setTitleColor(theme.textColor, for: UIControl.State.normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(editPressed), for: UIControl.Event.touchUpInside)
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
        field.textColor = theme.textColor
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var bioTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "bio"
        field.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        field.delegate = self
        field.isUserInteractionEnabled = false
        field.textColor = theme.textColor
        field.translatesAutoresizingMaskIntoConstraints = false
         return field
    }()
    
    private lazy var locationTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Location"
        field.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        field.delegate = self
        field.isUserInteractionEnabled = false
        field.textColor = theme.textColor
        field.translatesAutoresizingMaskIntoConstraints = false
         return field
    }()
    
    private lazy var cancelButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = theme.incomingMessageColor
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(theme.textColor, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(cancelPressed), for: UIControl.Event.touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var saveGCDButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = theme.incomingMessageColor
        button.setTitle("Save GCD", for: .normal)
        button.setTitleColor(theme.textColor, for: .normal)
        button.layer.cornerRadius = 10
        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(saveGCDPressed), for: UIControl.Event.touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var saveOperationsButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = theme.incomingMessageColor
        button.setTitle("Save Operations", for: .normal)
        button.setTitleColor(theme.textColor, for: .normal)
        button.layer.cornerRadius = 10
        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(saveOperationsPressed), for: UIControl.Event.touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var vc: UIViewController?
    
    init(frame: CGRect, vc: UIViewController) {
        self.vc = vc
        super.init(frame: CGRect.zero)
        self.backgroundColor = theme.mainColor
        addSubviews()
        setupConstraints()
        hideButtons()
        createDismissGesture()
        loadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
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
            
            saveGCDButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            saveGCDButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.46),
            saveGCDButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            saveGCDButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.08),
            
            saveOperationsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            saveOperationsButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.46),
            saveOperationsButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            saveOperationsButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.08),
            
            cancelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            cancelButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            cancelButton.bottomAnchor.constraint(equalTo: saveGCDButton.topAnchor, constant: -8),
            cancelButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.08),
            
            activityIndicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            activityIndicatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            activityIndicatorView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -20)
        ])
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
        addSubview(saveGCDButton)
        addSubview(saveOperationsButton)
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
    
    @objc private func addProfilePicture() {
        guard let vc = vc else {return}
        let allertControllerPresenter = AllertControllerPresenter()
        allertControllerPresenter.presentAlert(vc: vc)
    }
    
    private func loadData() {
        queue.async {
            self.showActivityIndicator()
            self.profileData = self.dataManager.loadData()
            DispatchQueue.main.async {
                self.loadTextFields(profileData: self.profileData)
            }
            self.hideActivityIndicator()
        }
    }
    
    private func showActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicatorView.isHidden = false
            self.activityIndicatorView.startAnimating()
        }
    }
    
    private func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.isHidden = true
        }
    }
    
    @objc private func editPressed() {
        nameTextField.isUserInteractionEnabled = true
        nameTextField.becomeFirstResponder()
        bioTextField.isUserInteractionEnabled = true
        locationTextField.isUserInteractionEnabled = true
        cancelButton.isHidden = false
        saveGCDButton.isHidden = false
        saveOperationsButton.isHidden = false
        editButton.isHidden = true
        
        
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
        cancelButton.isHidden = true
        saveGCDButton.isHidden = true
        saveOperationsButton.isHidden = true
        editButton.isHidden = false
        
        nameTextField.text = profileData?.name
        bioTextField.text = profileData?.bio
        locationTextField.text = profileData?.location
    }
    
    @objc private func saveGCDPressed() {
        saveGCDButton.isUserInteractionEnabled = false
        saveOperationsButton.isUserInteractionEnabled = false
        self.saveData(textFIeld: self.nameTextField,
                      text: self.profileData?.name,
                      file: self.nameFile)
        self.saveData(textFIeld: self.bioTextField,
                      text: self.profileData?.bio,
                      file: self.bioFile)
        self.saveData(textFIeld: self.locationTextField,
                      text: self.profileData?.location,
                      file: self.locationFile)
        profileData = ProfileData(name: nameTextField.text,
                                  bio: bioTextField.text,
                                  location: locationTextField.text)
        saveGCDButton.isHidden = true
        cancelButton.isHidden = true
        saveOperationsButton.isHidden = true
        editButton.isHidden = false
    }
    
    private func saveData(textFIeld: UITextField, text: String?, file: String) {
        let queue = DispatchQueue(label: "ru.apolinarys.serial2", qos: DispatchQoS.background)
        if textFIeld.text != text {
            if let inputText = textFIeld.text {
                queue.async {
                    self.showActivityIndicator()
                    if let dir = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory,
                                                          in: FileManager.SearchPathDomainMask.userDomainMask).first {
                        let fileURL = dir.appendingPathComponent(file)
                        
                        do {
                            try inputText.write(to: fileURL,
                                                atomically: false,
                                                encoding: String.Encoding.utf8)
                            print("Writing data done")
                        } catch {
                            print("Error writing data")
                        }
                    }
                    self.hideActivityIndicator()
                }
            }
        }
    }
    
    func loadTextFields(profileData: ProfileData?) {
        self.profileData = profileData
        nameTextField.text = profileData?.name
        locationTextField.text = profileData?.location
        bioTextField.text = profileData?.bio
    }
    
    @objc private func saveOperationsPressed() {
        
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
            saveGCDButton.isUserInteractionEnabled = true
            saveOperationsButton.isUserInteractionEnabled = true
        }
    }
    
    private func hideButtons() {
        cancelButton.isHidden = true
        saveGCDButton.isHidden = true
        saveOperationsButton.isHidden = true
    }

}

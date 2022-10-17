//
//  ViewController.swift
//  MessageApp
//
//  Created by Macbook on 22.09.2022.
//

import UIKit

protocol IProfileViewController: UIViewController {
    func saveButtonPressed()
    func showActivityIndicator()
    func hideActivityIndicator()
    func hideSavingButtons()
    func updateCellData(data: ProfileData?)
}

final class ProfileViewController: UIViewController, IProfileViewController {
    
    private let nameFile = "nameFile.txt"
    private let bioFile = "bioFile.txt"
    private let locationFile = "locationFile.txt"
    
    lazy var profileView = ProfileView(frame: CGRect.zero)
    private let theme = ThemeManager.currentTheme()
    var profileData: ProfileData?
    var presenter: IProfilePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        addSubviews()
        setupConstraints()
        addButtonActions()
        presenter?.loadData()
        view.backgroundColor = theme.mainColor
    }
    
    private func addSubviews() {
        view.addSubview(profileView)
    }
}

//MARK: - Cell Methods

extension ProfileViewController {
    
    func showActivityIndicator() {
        profileView.showActivityIndicator()
    }
    
    func hideActivityIndicator() {
        profileView.hideActivityIndicator()
    }
    
    func hideSavingButtons() {
        profileView.hideSavingButtons()
    }
    
    func updateCellData(data: ProfileData?) {
        profileView.updateData(data: data)
    }
}

//MARK: - UIImagePickerControllerDelegate

extension ProfileViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileView.profileImageView.contentMode = .scaleAspectFill
            profileView.profileImageView.image = pickedImage
        }
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Buttons

extension ProfileViewController {
    
    private func addButtonActions() {
        profileView.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: UIControl.Event.touchUpInside)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(addProfilePicturePressed))
        profileView.addPhotoView.addGestureRecognizer(gesture)
    }
    
    @objc private func addProfilePicturePressed() {
        profileView.showSavingButtons()
        presenter?.presentAlert()
    }
    
    @objc func saveButtonPressed() {
        profileView.saveButton.isUserInteractionEnabled = false
        profileView.cancelButton.isUserInteractionEnabled = false
        let data = [
            (profileView.nameTextField, profileData?.name, nameFile),
            (profileView.bioTextField, profileData?.bio, bioFile),
            (profileView.locationTextField, profileData?.location, locationFile)
        ]
        presenter?.saveData(data: data)
    }
}

//MARK: - Constraints

extension ProfileViewController {
    
    private func setupConstraints() {
        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

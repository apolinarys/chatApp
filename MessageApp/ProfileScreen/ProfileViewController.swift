//
//  ViewController.swift
//  MessageApp
//
//  Created by Macbook on 22.09.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private lazy var profileView = ProfileView(frame: CGRect.zero, vc: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(profileView)
    }
    
    private func setupConstraints() {
        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

//MARK: - Extension for UIImagePickerController

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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

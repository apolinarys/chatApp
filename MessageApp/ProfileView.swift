//
//  ProfileView.swift
//  MessageApp
//
//  Created by Macbook on 23.09.2022.
//

import UIKit

class ProfileView: UIView {

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
        button.backgroundColor = .white
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        return button
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            profileImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            
            addPhotoView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            addPhotoView.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor),
            addPhotoView.heightAnchor.constraint(equalToConstant: addPhotoView.layer.cornerRadius * 2),
            addPhotoView.widthAnchor.constraint(equalTo: addPhotoView.heightAnchor),
            
            photoImageView.centerXAnchor.constraint(equalTo: addPhotoView.centerXAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: addPhotoView.centerYAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 50),
            photoImageView.widthAnchor.constraint(equalTo: photoImageView.heightAnchor),
            
            editButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60),
            editButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            editButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    
    private func addSubviews() {
        addSubview(profileImageView)
        profileImageView.addSubview(addPhotoView)
        addPhotoView.addSubview(photoImageView)
        addSubview(editButton)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
    }
    
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

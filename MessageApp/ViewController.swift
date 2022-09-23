//
//  ViewController.swift
//  MessageApp
//
//  Created by Macbook on 22.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var profileView = ProfileView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(profileView)
        view.backgroundColor = .green
        let gesture = UITapGestureRecognizer(target: self, action: #selector(addProfilePicture))
        profileView.addPhotoView.isUserInteractionEnabled = true
        profileView.addPhotoView.addGestureRecognizer(gesture)
        setupConstraints()
    }
    
    @objc func addProfilePicture() {
        let alert = UIAlertController(title: "Add photo", message: "Please Select an Option", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Choose from gallery", style: .default , handler:{ (UIAlertAction)in
                print("User click Approve button")
            }))
            
            alert.addAction(UIAlertAction(title: "Take photo", style: .default , handler:{ (UIAlertAction)in
                print("User click Edit button")
            }))
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
                print("User click Dismiss button")
            }))

            present(alert, animated: true)
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


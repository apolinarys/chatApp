//
//  ViewController.swift
//  MessageApp
//
//  Created by Macbook on 22.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var profileView = ProfileView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(profileView.editButton.frame)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(profileView)
        print(profileView.editButton.frame)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(addProfilePicture))
        profileView.addPhotoView.isUserInteractionEnabled = true
        profileView.addPhotoView.addGestureRecognizer(gesture)
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(profileView.editButton.frame) // Frames are different because initialization of button and adding subviews (including button) happens after the view appeared
    }
    
    @objc func addProfilePicture() {
        let alert = UIAlertController(title: "Add photo", message: "Please Select an Option", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Choose from gallery", style: .default , handler:{ (UIAlertAction)in
                print("User click choose from galery button")
                self.didChoseGallery()
            }))
            
            alert.addAction(UIAlertAction(title: "Take photo", style: .default , handler:{ (UIAlertAction)in
                print("User click take photo button")
                self.didChoseTakePhoto()
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

//MARK: - Extension for UIImagePickerController

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func didChoseGallery() {
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func didChoseTakePhoto() {
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
        
        openCamera(imagePicker: imagePicker)
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera(imagePicker: UIImagePickerController)
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
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

//
//  PresentAlert.swift
//  MessageApp
//
//  Created by Macbook on 29.09.2022.
//

import UIKit

struct PresentAlert {
    
    static func presentAlert(vc: UIViewController) {
        let alert = UIAlertController(title: "Add photo",
                                      message: "Please Select an Option",
                                      preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Choose from gallery",
                                          style: .default ,
                                          handler: { (UIAlertAction)in
                print("User click choose from galery button")
                didChoseGallery(vc: vc)
            }))
            
            alert.addAction(UIAlertAction(title: "Take photo",
                                          style: .default ,
                                          handler:{ (UIAlertAction)in
                print("User click take photo button")
                didChoseTakePhoto(vc: vc)
            }))
            
            alert.addAction(UIAlertAction(title: "Dismiss",
                                          style: .cancel,
                                          handler:{ (UIAlertAction)in
                print("User click Dismiss button")
            }))

        vc.present(alert, animated: true)
    }
    
    static func didChoseGallery(vc: UIViewController) {
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = vc as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        vc.present(imagePicker, animated: true, completion: nil)
    }
    
    static func didChoseTakePhoto(vc: UIViewController) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = vc as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        openCamera(imagePicker: imagePicker, vc: vc)
        vc.present(imagePicker, animated: true, completion: nil)
    }
    
    static func openCamera(imagePicker: UIImagePickerController, vc: UIViewController)
    {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            vc.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning",
                                           message: "You don't have camera",
                                           preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil))
            vc.present(alert, animated: true, completion: nil)
        }
    }
}

//
//  PresentAlert.swift
//  MessageApp
//
//  Created by Macbook on 29.09.2022.
//

import UIKit

struct AllertControllerPresenter {
    
    func presentAlert(vc: UIViewController) {
        let alert = UIAlertController(title: "Add photo",
                                      message: "Please Select an Option",
                                      preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Choose from gallery",
                                          style: UIAlertAction.Style.default ,
                                          handler: { (UIAlertAction)in
                didChoseGallery(vc: vc)
            }))
            
            alert.addAction(UIAlertAction(title: "Take photo",
                                          style: UIAlertAction.Style.default ,
                                          handler:{ (UIAlertAction)in
                didChoseTakePhoto(vc: vc)
            }))
            
            alert.addAction(UIAlertAction(title: "Dismiss",
                                          style: UIAlertAction.Style.cancel,
                                          handler:{ (UIAlertAction)in
            }))

        vc.present(alert, animated: true)
    }
    
    private func didChoseGallery(vc: UIViewController) {
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = vc as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        vc.present(imagePicker, animated: true, completion: nil)
    }
    
    private func didChoseTakePhoto(vc: UIViewController) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = vc as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        openCamera(imagePicker: imagePicker, vc: vc)
        vc.present(imagePicker, animated: true, completion: nil)
    }
    
    private func openCamera(imagePicker: UIImagePickerController, vc: UIViewController)
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
                                           preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: UIAlertAction.Style.default,
                                          handler: nil))
            vc.present(alert, animated: true, completion: nil)
        }
    }
}

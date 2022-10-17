//
//  AlertPresenter.swift
//  MessageApp
//
//  Created by Macbook on 06.10.2022.
//

import UIKit

struct AlertPresenter {
    
    func showSuccessAlert(vc: UIViewController?, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "Data was successfully saved",
                                      message: "",
                                      preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { action in
            completion()
        }
        alert.addAction(action)
        
        vc?.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(vc: UIViewController?, completion: @escaping (AlertPresenterCondition) -> Void) {
        let alert = UIAlertController(title: "Error saving data",
                                      message: "Cannot save data",
                                      preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { action in
            completion(AlertPresenterCondition.okActionPressed)
        }
        
        let repeatAction = UIAlertAction(title: "Repeat", style: UIAlertAction.Style.default) { action in
            completion(AlertPresenterCondition.repeatActionPressed)
        }
        alert.addAction(repeatAction)
        alert.addAction(okAction)
        
        vc?.present(alert, animated: true, completion: nil)
    }
    
    func showNewChannelAlert(vc: UIViewController?, addChannel: @escaping (_ name: String) -> Void) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Channel",
                                      message: "",
                                      preferredStyle: UIAlertController.Style.alert)
        
        let addAction = UIAlertAction(title: "Add", style: UIAlertAction.Style.default) { action in
            if let text = textField.text {
                addChannel(text)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { action in
            alert.dismiss(animated: true)
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        vc?.present(alert, animated: true, completion: nil)
    }
    
    func showNoProfileInformationAlert(vc: UIViewController?) {
        let alert = UIAlertController(title: "No profile info",
                                      message: "Add name to your profile",
                                      preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        
        alert.addAction(okAction)
        
        vc?.present(alert, animated: true)
    }
}

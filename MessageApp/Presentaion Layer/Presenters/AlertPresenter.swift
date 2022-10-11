//
//  AlertPresenter.swift
//  MessageApp
//
//  Created by Macbook on 06.10.2022.
//

import UIKit

struct AlertPresenter {
    
    var vc: UIViewController?
    
    func showSuccessAlert(hideSavingButtons: @escaping () -> Void) {
        let alert = UIAlertController(title: "Data was successfully saved",
                                      message: "",
                                      preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { action in
            
            hideSavingButtons()
        }
        alert.addAction(action)
        
        vc?.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(hideSavingButtons: @escaping () -> Void,
                        buttonAction: @escaping (_ data: [(UITextField, String?, String)],
                                                 _ hideSavingButtons: @escaping () -> Void,
                                                 _ vc: UIViewController?,
                                                 _ activityIndicator: UIActivityIndicatorView) -> Void,
                        data: [(UITextField, String?, String)],
                        activityIndicator: UIActivityIndicatorView) {
        let alert = UIAlertController(title: "Error saving data",
                                      message: "Cannot save data",
                                      preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { action in
            
            hideSavingButtons()
        }
        
        let repeatAction = UIAlertAction(title: "Repeat", style: UIAlertAction.Style.default) { action in
            buttonAction(data, hideSavingButtons, vc, activityIndicator)
        }
        alert.addAction(repeatAction)
        alert.addAction(okAction)
        
        vc?.present(alert, animated: true, completion: nil)
    }
    
    func showNewChannelAlert(addChannel: @escaping (_ name: String) -> Void) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Channel", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { action in
            if let text = textField.text {
                addChannel(text)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { action in
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
}

//
//  AlertPresenter.swift
//  MessageApp
//
//  Created by Macbook on 06.10.2022.
//

import UIKit

struct AlertPresenter {
    
    var hideSavingButtons: () -> Void
    
    func showSuccessAlert(vc: UIViewController?) {
        let alert = UIAlertController(title: "Data was successfully saved",
                                      message: "",
                                      preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { action in
            
            hideSavingButtons()
        }
        alert.addAction(action)
        
        vc?.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(buttonAction: @escaping (_ textFIeld: UITextField,
                                 _ text: String?,
                                 _ file: String) -> Void,
                        textField: UITextField,
                        text: String?,
                        file: String,
                        vc: UIViewController?) {
        let alert = UIAlertController(title: "Error saving data",
                                      message: "Cannot save data",
                                      preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { action in
            
            hideSavingButtons()
        }
        
        let repeatAction = UIAlertAction(title: "Repeat", style: UIAlertAction.Style.default) { action in
            buttonAction(textField, text, file)
        }
        alert.addAction(repeatAction)
        alert.addAction(okAction)
        
        vc?.present(alert, animated: true, completion: nil)
    }
}

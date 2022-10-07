//
//  OperationsManager.swift
//  MessageApp
//
//  Created by Macbook on 06.10.2022.
//

import UIKit

struct OperationsManager {
    var hideSavingButtons: () -> Void
    var vc: UIViewController?
    var activityIndicator: UIActivityIndicatorView
    
    func saveData(textField: UITextField,
                          text: String?,
                          file: String) {
        let savingQueue = OperationQueue()
        if textField.text != text {
            if let inputText = textField.text {
                savingQueue.addOperation {
                    showActivityIndicator(activityIndicatorView: activityIndicator)
                    if let dir = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory,
                                                          in: FileManager.SearchPathDomainMask.userDomainMask).first {
                        let fileURL = dir.appendingPathComponent(file)
                        
                        do {
                            try inputText.write(to: fileURL,
                                                atomically: false,
                                                encoding: String.Encoding.utf8)
                        } catch {
                            let alertPresenter = AlertPresenter(vc: vc)
                            alertPresenter.showErrorAlert(hideSavingButtons: hideSavingButtons,
                                                          buttonAction: saveData,
                                                          textField: textField,
                                                          text: text,
                                                          file: file)
                        }
                    }
                    hideActivityIndicator(activityIndicatorView: activityIndicator)
                }
            }
        }
    }
    
    private func showActivityIndicator(activityIndicatorView: UIActivityIndicatorView) {
        OperationQueue.main.addOperation {
            activityIndicatorView.isHidden = false
            activityIndicatorView.startAnimating()
        }
    }
    
    private func hideActivityIndicator(activityIndicatorView: UIActivityIndicatorView) {
        OperationQueue.main.addOperation {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.isHidden = true
        }
    }
}

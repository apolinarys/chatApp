//
//  GCDManager.swift
//  MessageApp
//
//  Created by Macbook on 06.10.2022.
//

import UIKit

struct GCDManager {
    
    var hideSavingButtons: () -> Void
    var vc: UIViewController?
    var activityIndicator: UIActivityIndicatorView
    
    func saveData(textField: UITextField,
                          text: String?,
                          file: String) {
        let queue = DispatchQueue(label: "ru.apolinarys.serial2", qos: DispatchQoS.background)
        if textField.text != text {
            if let inputText = textField.text {
                queue.async {
                    self.showActivityIndicator(activityIndicatorView: activityIndicator)
                    if let dir = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory,
                                                          in: FileManager.SearchPathDomainMask.userDomainMask).first {
                        let fileURL = dir.appendingPathComponent(file)
                        
                        do {
                            try inputText.write(to: fileURL,
                                                atomically: false,
                                                encoding: String.Encoding.utf8)
                        } catch {
                            let alertPresenter = AlertPresenter(hideSavingButtons: hideSavingButtons)
                            alertPresenter.showErrorAlert(buttonAction: saveData,
                                                          textField: textField,
                                                          text: text,
                                                          file: file,
                                                          vc: vc)
                        }
                    }
                    self.hideActivityIndicator(activityIndicatorView: activityIndicator)
                }
            }
        }
    }
    
    private func showActivityIndicator(activityIndicatorView: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            activityIndicatorView.isHidden = false
            activityIndicatorView.startAnimating()
        }
    }
    
    private func hideActivityIndicator(activityIndicatorView: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.isHidden = true
        }
    }
}

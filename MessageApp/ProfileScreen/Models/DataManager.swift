//
//  DataManager.swift
//  MessageApp
//
//  Created by Macbook on 05.10.2022.
//

import UIKit

struct ProfileData {
    var name: String?
    var bio: String?
    var location: String?
}

protocol DataManagerDelegate {
    func updateData(data: ProfileData?)
}

struct DataManager {
    
    private let nameFile = "nameFile.txt"
    private let bioFile = "bioFile.txt"
    private let locationFile = "locationFile.txt"
    private let queue = DispatchQueue(label: "ru.apolinarys.serial", qos: DispatchQoS.background)
    var delegate: DataManagerDelegate?
    
    func loadData() {
        var profileData: ProfileData? = nil
        if let dir = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first {
            let nameFileURL = dir.appendingPathComponent(self.nameFile)
            let bioFileURL = dir.appendingPathComponent(self.bioFile)
            let locationFileURL = dir.appendingPathComponent(self.locationFile)
            
            queue.async {
                do {
                    let name = try String(contentsOf: nameFileURL, encoding: String.Encoding.utf8)
                    let bio = try String(contentsOf: bioFileURL, encoding: String.Encoding.utf8)
                    let location = try String(contentsOf: locationFileURL, encoding: String.Encoding.utf8)
                    profileData = ProfileData(name: name, bio: bio, location: location)
                    delegate?.updateData(data: profileData)
                } catch {
                    print("Error reading data")
                }
            }
        }
    }
    
    func saveData(textField: UITextField,
                  text: String?,
                  file: String,
                  hideSavingButtons: @escaping () -> Void,
                  vc: UIViewController?,
                  activityIndicator: UIActivityIndicatorView) {
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
                            let alertPresenter = AlertPresenter(vc: vc)
                            alertPresenter.showErrorAlert(hideSavingButtons: hideSavingButtons,
                                                          buttonAction: saveData,
                                                          textField: textField,
                                                          text: text,
                                                          file: file,
                                                          activityIndicator: activityIndicator)
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

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

struct DataManager {
    
    private let nameFile = "nameFile.txt"
    private let bioFile = "bioFile.txt"
    private let locationFile = "locationFile.txt"
    private let queue = DispatchQueue(label: "ru.apolinarys.serial", qos: DispatchQoS.background)
    
    func loadData(completion: @escaping (ProfileData?) -> Void) {
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
                    DispatchQueue.main.async {
                        completion(profileData)
                    }
                } catch {
                    print("Error reading data")
                }
            }
        }
    }
    
    func saveData(data: [(UITextField, String?, String)],
                  hideSavingButtons: @escaping () -> Void,
                  vc: UIViewController?,
                  activityIndicator: UIActivityIndicatorView) {
        let queue = DispatchQueue(label: "ru.apolinarys.serial2", qos: DispatchQoS.background)
        data.forEach {
            let textField = $0.0
            let text = $0.1
            let file = $0.2
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
                                                              data: data,
                                                              activityIndicator: activityIndicator)
                            }
                        }
                        self.hideActivityIndicator(activityIndicatorView: activityIndicator)
                    }
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

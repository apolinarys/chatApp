//
//  StorageManager.swift
//  MessageApp
//
//  Created by Macbook on 11.10.2022.
//

import UIKit

protocol IStorageManager {
    func loadData(completion: @escaping (StorageManagerResult) -> Void)
    func saveData(data: [(UITextField, String?, String)],
                  completion: @escaping (Result<StorageManagerResult, Error>) -> Void)
}

struct StorageManager: IStorageManager {
    
    private let nameFile = "nameFile.txt"
    private let bioFile = "bioFile.txt"
    private let locationFile = "locationFile.txt"
    private let queue = DispatchQueue(label: "ru.apolinarys.serial", qos: DispatchQoS.background)
    
    func loadData(completion: @escaping (StorageManagerResult) -> Void) {
        
        guard let dir = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first else {return}
        let nameFileURL = dir.appendingPathComponent(self.nameFile)
        let bioFileURL = dir.appendingPathComponent(self.bioFile)
        let locationFileURL = dir.appendingPathComponent(self.locationFile)
        
        queue.async {
            DispatchQueue.main.async {
                completion(StorageManagerResult.started)
            }
            do {
                let name = try String(contentsOf: nameFileURL, encoding: String.Encoding.utf8)
                let bio = try String(contentsOf: bioFileURL, encoding: String.Encoding.utf8)
                let location = try String(contentsOf: locationFileURL, encoding: String.Encoding.utf8)
                let profileData = ProfileData(name: name, location: location, bio: bio)
                DispatchQueue.main.async {
                    completion(StorageManagerResult.finished(profileData))
                }
            } catch {
                Logger.shared.message("Error reading data")
            }
        }
    }
    
    func saveData(data: [(UITextField, String?, String)],
                  completion: @escaping (Result<StorageManagerResult, Error>) -> Void) {
        data.forEach {
            let textField = $0.0
            let text = $0.1
            let file = $0.2
            if textField.text != text, let inputText = textField.text {
                queue.async {
                    DispatchQueue.main.async {
                        completion(Result.success(StorageManagerResult.started))
                    }
                    if let dir = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory,
                                                          in: FileManager.SearchPathDomainMask.userDomainMask).first {
                        let fileURL = dir.appendingPathComponent(file)
                        do {
                            try inputText.write(to: fileURL,
                                                atomically: false,
                                                encoding: String.Encoding.utf8)
                        } catch {
                            DispatchQueue.main.async {
                                completion(Result.failure(error))
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        completion(Result.success(StorageManagerResult.finished(nil)))
                    }
                }
            }
        }
    }
}

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
    
    func loadData() -> ProfileData? {
        var profileData: ProfileData? = nil
        if let dir = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first {
            let nameFileURL = dir.appendingPathComponent(self.nameFile)
            let bioFileURL = dir.appendingPathComponent(self.bioFile)
            let locationFileURL = dir.appendingPathComponent(self.locationFile)
            
            do {
                let name = try String(contentsOf: nameFileURL, encoding: String.Encoding.utf8)
                let bio = try String(contentsOf: bioFileURL, encoding: String.Encoding.utf8)
                let location = try String(contentsOf: locationFileURL, encoding: String.Encoding.utf8)
                profileData = ProfileData(name: name, bio: bio, location: location)
            } catch {
                print("Error reading data")
            }
        }
        return profileData
    }
}

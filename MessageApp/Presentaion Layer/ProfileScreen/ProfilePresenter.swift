//
//  ProfilePresenter.swift
//  MessageApp
//
//  Created by Macbook on 11.10.2022.
//

import UIKit

protocol IProfilePresenter {
    func saveData(data: [(UITextField, String?, String)])
    func loadData()
    func presentAlert()
}

struct ProfilePresenter: IProfilePresenter {
    
    weak var vc: IProfileViewController?
    let router: IRouter
    let storageManager: StorageManager
    let allertControllerPresenter: AllertControllerPresenter
    
    func saveData(data: [(UITextField, String?, String)]) {
        storageManager.saveData(data: data) { result in
            switch result {
            case .success(let profileResult):
                switch profileResult {
                case .started:
                    vc?.showActivityIndicator()
                case .finished:
                    vc?.hideActivityIndicator()
                    let alertPresenter = AlertPresenter()
                    alertPresenter.showSuccessAlert(vc: vc) {
                        vc?.hideSavingButtons()
                    }
                }
            case .failure(let error):
                Logger.shared.message(error.localizedDescription)
                let alertPresenter = AlertPresenter()
                alertPresenter.showErrorAlert(vc: vc) { condition in
                    switch condition {
                    case .okActionPressed:
                        vc?.hideSavingButtons()
                    case .repeatActionPressed:
                        vc?.saveButtonPressed()
                    }
                }
            }
        }
    }
    
    func loadData() {
        storageManager.loadData { result in
            switch result {
            case .started:
                vc?.showActivityIndicator()
            case .finished(let profileData):
                vc?.updateCellData(data: profileData)
                vc?.hideActivityIndicator()
            }
        }
    }
    
    func presentAlert() {
        guard let vc = vc else {return}
        allertControllerPresenter.presentAlert(vc: vc)
    }
}

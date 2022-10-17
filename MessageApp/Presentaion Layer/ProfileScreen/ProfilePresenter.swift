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
    
    func onViewDidLoad() {
        vc?.profileView.theme = ThemeManager.currentTheme()
    }
    
    func saveData(data: [(UITextField, String?, String)]) {
        storageManager.saveData(data: data) { result in
            switch result {
            case .success(let profileResult):
                switch profileResult {
                case .started:
                    vc?.profileView.showActivityIndicator()
                case .finished:
                    vc?.profileView.hideActivityIndicator()
                    let alertPresenter = AlertPresenter(vc: vc)
                    alertPresenter.showSuccessAlert {
                        vc?.profileView.hideSavingButtons()
                    }
                }
            case .failure(let error):
                Logger.shared.message(error.localizedDescription)
                let alertPresenter = AlertPresenter(vc: vc)
                alertPresenter.showErrorAlert { condition in
                    switch condition {
                    case .okActionPressed:
                        vc?.profileView.hideSavingButtons()
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
                vc?.profileView.showActivityIndicator()
            case .finished(let profileData):
                vc?.profileView.updateData(data: profileData)
                vc?.profileView.hideActivityIndicator()
            }
        }
    }
    
    func presentAlert() {
        guard let vc = vc else {return}
        allertControllerPresenter.presentAlert(vc: vc)
    }
}

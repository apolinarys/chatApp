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
}

struct ProfilePresenter: IProfilePresenter {
    
    weak var view: IProfileView?
    weak var vc: IProfileViewController?
    let router: IRouter
    let storageManager: StorageManager
    
    func onViewDidLoad() {
        view?.theme = ThemeManager.currentTheme()
    }
    
    func saveData(data: [(UITextField, String?, String)]) {
        storageManager.saveData(data: data, vc: view?.vc) { result in
            switch result {
            case .success(let profileResult):
                switch profileResult {
                case .started:
                    view?.showActivityIndicator()
                case .finished:
                    view?.hideActivityIndicator()
                    let alertPresenter = AlertPresenter(vc: view?.vc)
                    alertPresenter.showSuccessAlert {
                        view?.hideSavingButtons()
                    }
                }
            case .failure(let error):
                Logger.shared.message(error.localizedDescription)
                let alertPresenter = AlertPresenter(vc: view?.vc)
                alertPresenter.showErrorAlert { condition in
                    switch condition {
                    case .okActionPressed:
                        view?.hideSavingButtons()
                    case .repeatActionPressed:
                        view?.saveButtonPressed()
                    }
                }
            }
        }
    }
    
    func loadData() {
        storageManager.loadData { result in
            switch result {
            case .started:
                view?.showActivityIndicator()
            case .finished(let profileData):
                view?.updateData(data: profileData)
                view?.hideActivityIndicator()
            }
        }
    }
    
    func presentAlert() {
        guard let vc = vc else {return}
        let allertControllerPresenter = AllertControllerPresenter()
        allertControllerPresenter.presentAlert(vc: vc)
    }
}

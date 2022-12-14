//
//  ThemesViewController.swift
//  MessageApp
//
//  Created by Macbook on 28.09.2022.
//

import UIKit

final class ThemesViewController: UIViewController {
    
    private lazy var themesView = ThemesView(frame: CGRect.zero)
    var presenter: IThemePresenter?
    
    static var theme: Theme? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 26/255, green: 54/255, blue: 97/255, alpha: 1)
        setupNavigationController()
        addSubviews()
        setupConstraints()
    }
}

//MARK: - NavigationController

extension ThemesViewController {
    
    private func setupNavigationController() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        navigationItem.rightBarButtonItem = cancelButton
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func cancelPressed() {
        presenter?.cancelPressed()
    }
    
    @objc private func backPressed() {
        presenter?.backPressed()
    }
}

//MARK: - Constraints

extension ThemesViewController {
    
    private func addSubviews() {
        view.addSubview(themesView)
    }
    
    private func setupConstraints() {
        themesView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            themesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            themesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            themesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            themesView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

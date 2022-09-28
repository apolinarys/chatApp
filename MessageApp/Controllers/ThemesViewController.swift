//
//  ThemesViewController.swift
//  MessageApp
//
//  Created by Macbook on 28.09.2022.
//

import UIKit

final class ThemesViewController: UIViewController {
    
    private lazy var themesView = ThemesView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        setupView()

        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        view.addSubview(themesView)
        themesView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            themesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            themesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            themesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            themesView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

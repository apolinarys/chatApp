//
//  ThemesView.swift
//  MessageApp
//
//  Created by Macbook on 28.09.2022.
//

import UIKit

final class ThemesView: UIStackView {
    
    private lazy var classicView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var classicButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    private lazy var firstMessageBubble: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = .gray
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        return view
    }()
    
    private lazy var secondMessageBubble: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = .gray
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        return view
    }()
    
    private lazy var classicLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Classic"
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        label.contentMode = .center
        return label
    }()
    
    private lazy var dayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    private lazy var thirdMessageBubble: UIView = {
        let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.layer.cornerRadius = 15
         view.backgroundColor = .gray
         view.isUserInteractionEnabled = true
         view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
         return view
    }()
    
    private lazy var fourthMessageBubble: UIView = {
        let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.layer.cornerRadius = 15
         view.backgroundColor = .gray
         view.isUserInteractionEnabled = true
         view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
         return view
    }()
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Day"
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        label.contentMode = .center
        return label
    }()
    
    private lazy var nightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    private lazy var fifthMessageBubble: UIView = {
        let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.layer.cornerRadius = 15
         view.backgroundColor = .gray
         view.isUserInteractionEnabled = true
         view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
         return view
    }()
    
    private lazy var sixthMessageBubble: UIView = {
        let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.layer.cornerRadius = 15
         view.backgroundColor = .gray
         view.isUserInteractionEnabled = true
         view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
         return view
    }()
    
    private lazy var nightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Night"
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        label.contentMode = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillEqually
        addSubviews()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tap() {
        print("tap")
    }
    
    private func addSubviews() {
        self.addArrangedSubview(classicView)
        classicView.addSubview(classicButton)
        classicButton.addSubview(firstMessageBubble)
        classicButton.addSubview(secondMessageBubble)
        classicView.addSubview(classicLabel)
        
        self.addArrangedSubview(dayView)
        dayView.addSubview(dayButton)
        dayButton.addSubview(thirdMessageBubble)
        dayButton.addSubview(fourthMessageBubble)
        dayView.addSubview(dayLabel)
        
        self.addArrangedSubview(nightView)
        nightView.addSubview(nightButton)
        nightButton.addSubview(fifthMessageBubble)
        nightButton.addSubview(sixthMessageBubble)
        nightView.addSubview(nightLabel)
    }
    
    private func setupConstraints() {
        
        let buttonHight: CGFloat = 80
        
        NSLayoutConstraint.activate([
            classicButton.centerYAnchor.constraint(equalTo: classicView.centerYAnchor, constant: -10),
            classicButton.leadingAnchor.constraint(equalTo: classicView.leadingAnchor, constant: 10),
            classicButton.trailingAnchor.constraint(equalTo: classicView.trailingAnchor, constant: -10),
            classicButton.heightAnchor.constraint(equalToConstant: buttonHight),
            
            firstMessageBubble.topAnchor.constraint(equalTo: classicButton.topAnchor, constant: 8),
            firstMessageBubble.heightAnchor.constraint(equalTo: classicButton.heightAnchor, multiplier: 0.5),
            firstMessageBubble.leadingAnchor.constraint(equalTo: classicButton.leadingAnchor, constant: 20),
            firstMessageBubble.trailingAnchor.constraint(equalTo: classicButton.centerXAnchor, constant: -2),
            
            secondMessageBubble.bottomAnchor.constraint(equalTo: classicButton.bottomAnchor, constant: -8),
            secondMessageBubble.heightAnchor.constraint(equalTo: classicButton.heightAnchor, multiplier: 0.5),
            secondMessageBubble.leadingAnchor.constraint(equalTo: classicButton.centerXAnchor, constant: 2),
            secondMessageBubble.trailingAnchor.constraint(equalTo: classicButton.trailingAnchor, constant: -20),
            
            classicLabel.topAnchor.constraint(equalTo: classicButton.bottomAnchor, constant: 15),
            classicLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            dayButton.centerYAnchor.constraint(equalTo: dayView.centerYAnchor, constant: -10),
            dayButton.leadingAnchor.constraint(equalTo: dayView.leadingAnchor, constant: 10),
            dayButton.trailingAnchor.constraint(equalTo: dayView.trailingAnchor, constant: -10),
            dayButton.heightAnchor.constraint(equalToConstant: buttonHight),

            thirdMessageBubble.topAnchor.constraint(equalTo: dayButton.topAnchor, constant: 8),
            thirdMessageBubble.heightAnchor.constraint(equalTo: dayButton.heightAnchor, multiplier: 0.5),
            thirdMessageBubble.leadingAnchor.constraint(equalTo: dayButton.leadingAnchor, constant: 20),
            thirdMessageBubble.trailingAnchor.constraint(equalTo: dayButton.centerXAnchor, constant: -2),

            fourthMessageBubble.bottomAnchor.constraint(equalTo: dayButton.bottomAnchor, constant: -8),
            fourthMessageBubble.heightAnchor.constraint(equalTo: dayButton.heightAnchor, multiplier: 0.5),
            fourthMessageBubble.leadingAnchor.constraint(equalTo: dayButton.centerXAnchor, constant: 2),
            fourthMessageBubble.trailingAnchor.constraint(equalTo: dayButton.trailingAnchor, constant: -20),
            
            dayLabel.topAnchor.constraint(equalTo: dayButton.bottomAnchor, constant: 15),
            dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            nightButton.centerYAnchor.constraint(equalTo: nightView.centerYAnchor, constant: -10),
            nightButton.leadingAnchor.constraint(equalTo: nightView.leadingAnchor, constant: 10),
            nightButton.trailingAnchor.constraint(equalTo: nightView.trailingAnchor, constant: -10),
            nightButton.heightAnchor.constraint(equalToConstant: buttonHight),

            fifthMessageBubble.topAnchor.constraint(equalTo: nightButton.topAnchor, constant: 8),
            fifthMessageBubble.heightAnchor.constraint(equalTo: nightButton.heightAnchor, multiplier: 0.5),
            fifthMessageBubble.leadingAnchor.constraint(equalTo: nightButton.leadingAnchor, constant: 20),
            fifthMessageBubble.trailingAnchor.constraint(equalTo: nightButton.centerXAnchor, constant: -2),

            sixthMessageBubble.bottomAnchor.constraint(equalTo: nightButton.bottomAnchor, constant: -8),
            sixthMessageBubble.heightAnchor.constraint(equalTo: nightButton.heightAnchor, multiplier: 0.5),
            sixthMessageBubble.leadingAnchor.constraint(equalTo: nightButton.centerXAnchor, constant: 2),
            sixthMessageBubble.trailingAnchor.constraint(equalTo: nightButton.trailingAnchor, constant: -20),
            
            nightLabel.topAnchor.constraint(equalTo: nightButton.bottomAnchor, constant: 15),
            nightLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}

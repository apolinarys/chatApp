//
//  ConversationTableViewCell.swift
//  MessageApp
//
//  Created by Macbook on 26.09.2022.
//

import UIKit

final class ConversationTableViewCell: UITableViewCell {
    
    let theme = ThemeManager.currentTheme()
    
    private lazy var messageBubble: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Message body"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(messageBubble)
        messageBubble.addSubview(messageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            messageBubble.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            messageBubble.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            messageBubble.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.66),
            
            messageLabel.topAnchor.constraint(equalTo: messageBubble.topAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: messageBubble.bottomAnchor, constant: -8),
            messageLabel.leadingAnchor.constraint(equalTo: messageBubble.leadingAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: messageBubble.trailingAnchor, constant: -8),
        ])
    }
    
    func set(data: Message) {
            messageBubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
            messageBubble.backgroundColor = theme.incomingMessageColor
        messageLabel.text = data.content
    }
    
    override func prepareForReuse() {
        messageBubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = false
        messageBubble.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = false
    }
}

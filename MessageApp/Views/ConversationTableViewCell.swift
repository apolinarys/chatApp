//
//  ConversationTableViewCell.swift
//  MessageApp
//
//  Created by Macbook on 26.09.2022.
//

import UIKit

final class ConversationTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ConversationTableViewCell"
    
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
    
    private lazy var senderAvatar: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        return imageView
    }()
    
    private lazy var receiverAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.crop.circle")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(messageBubble)
        contentView.addSubview(senderAvatar)
        contentView.addSubview(receiverAvatar)
        messageBubble.addSubview(messageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            messageBubble.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            messageBubble.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            messageBubble.leadingAnchor.constraint(equalTo: senderAvatar.trailingAnchor, constant: 8),
            messageBubble.trailingAnchor.constraint(equalTo: receiverAvatar.leadingAnchor, constant: -8),
            
            messageLabel.topAnchor.constraint(equalTo: messageBubble.topAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: messageBubble.bottomAnchor, constant: -8),
            messageLabel.leadingAnchor.constraint(equalTo: messageBubble.leadingAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: messageBubble.trailingAnchor, constant: -8),
            
            senderAvatar.heightAnchor.constraint(equalToConstant: 50),
            senderAvatar.widthAnchor.constraint(equalTo: senderAvatar.heightAnchor),
            senderAvatar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            senderAvatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            receiverAvatar.heightAnchor.constraint(equalToConstant: 50),
            receiverAvatar.widthAnchor.constraint(equalTo: receiverAvatar.heightAnchor),
            receiverAvatar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            receiverAvatar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    func set(data: MessageCell) {
        messageLabel.text = data.text
        if data.isIncoming {
            senderAvatar.isHidden = true
            receiverAvatar.isHidden = false
            messageBubble.backgroundColor = UIColor(red: 0.863, green: 0.969, blue: 0.773, alpha: 1)
        } else {
            receiverAvatar.isHidden = true
            senderAvatar.isHidden = false
            messageBubble.backgroundColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1)
        }
    }
}

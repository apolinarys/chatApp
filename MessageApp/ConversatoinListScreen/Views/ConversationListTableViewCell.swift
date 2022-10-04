//
//  ConversationListTableViewCell.swift
//  MessageApp
//
//  Created by Macbook on 26.09.2022.
//

import UIKit

final class ConversationListTableViewCell: UITableViewCell {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.light)
        return label
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            messageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(messageLabel)
        contentView.addSubview(dateLabel)
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
        messageLabel.text = nil
        dateLabel.text = nil
        messageLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
    }
    
    func set(data: ConversationCell, theme: Theme) {
        nameLabel.text = data.name
        messageLabel.text = data.message
        if data.message == nil {
            messageLabel.text = "No messages yet"
        }
        messageLabel.textColor = theme.textColor
        dateLabel.textColor = theme.textColor
        nameLabel.textColor = theme.textColor
        self.backgroundColor = theme.mainColor
        if let date = data.date {
            let isDayInToday = Calendar.current.isDateInToday(date)
            let dateFormatter = DateFormatter()
            if isDayInToday {
                dateFormatter.dateFormat = "HH:mm"
            } else {
                dateFormatter.dateFormat = "dd.MM"
                
            }
            dateLabel.text = dateFormatter.string(from: date)
        }
        if data.hasUnreadMessages {
            messageLabel.font = .systemFont(ofSize: 15, weight: UIFont.Weight.heavy)
        }
        if data.online {
            self.backgroundColor = theme.outgoingMessageColor
        }
    }
}

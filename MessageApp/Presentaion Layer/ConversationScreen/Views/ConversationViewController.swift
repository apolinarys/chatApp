//
//  ConversationViewController.swift
//  MessageApp
//
//  Created by Macbook on 26.09.2022.
//

import UIKit

protocol IMessageView: UIViewController {
    var presenter: IMessagesPresenter? {get set}
    
    func updateUI(messages: [Message])
}

final class ConversationViewController: UIViewController, UITextViewDelegate, IMessageView {
    
    private lazy var tableView = UITableView(frame: CGRect.zero)
    private let theme = ThemeManager.currentTheme()
    var messages: [Message] = []
    
    var presenter: IMessagesPresenter?
    
    private lazy var textView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 14)
        view.isEditable = true
        view.showsVerticalScrollIndicator = true
        view.isScrollEnabled = false
        view.isUserInteractionEnabled = true
        view.contentMode = UIView.ContentMode.scaleToFill
        return view
    }()
    
    private lazy var messageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = theme.incomingMessageColor
        return view
    }()
    
    private lazy var sendMessageButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "paperplane.fill"), for: UIControl.State.normal)
        button.tintColor = UIColor(red: 63/255, green: 120/255, blue: 240/255, alpha: 1)
        button.addTarget(self, action: #selector(sendMessage), for: UIControl.Event.touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        setupTableView()
        createDismissGesture()
        presenter?.onViewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        textView.delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == textView {
            if textView.frame.size.height < view.frame.size.height * 0.3 {
                textView.frame.size.height = 100
                textView.sizeToFit()
            } else {
                textView.frame.size.height = view.frame.size.height * 0.3
                textView.isScrollEnabled = true
            }
        }
    }
    
    private func createDismissGesture() {
        tableView.isUserInteractionEnabled = true
        view.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tableView.addGestureRecognizer(gesture)
    }
    
    @objc private func dismissKeyboard() {
        textView.resignFirstResponder()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(messageView)
        messageView.addSubview(textView)
        messageView.addSubview(sendMessageButton)
    }
    
    @objc private func sendMessage() {
        print(#function)
        presenter?.sendMessage(message: textView.text)
        textView.text = ""
    }

    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            messageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageView.topAnchor.constraint(equalTo: textView.topAnchor, constant: -16),
            
            sendMessageButton.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -8),
            sendMessageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            sendMessageButton.heightAnchor.constraint(equalToConstant: 40),
            sendMessageButton.widthAnchor.constraint(equalTo: sendMessageButton.heightAnchor),
            
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            textView.trailingAnchor.constraint(equalTo: sendMessageButton.leadingAnchor, constant: -8),
            textView.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 8),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageView.topAnchor)
        ])
        textView.frame.size.height = 30
    }
    
    private func setupTableView() {
        tableView.register(ConversationTableViewCell.self, forCellReuseIdentifier: String(describing: ConversationTableViewCell.self))
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
}

//MARK: - UITableViewDataSource

extension ConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ConversationTableViewCell.self)) as? ConversationTableViewCell
        guard let cell = cell else {return UITableViewCell()}
        cell.set(data: messages[indexPath.row])
        return cell
    }
}

//MARK: - MessagesListManagerDelegate

extension ConversationViewController {
    
    func updateUI(messages: [Message]) {
        print("Updating UI")
        self.messages += messages
        tableView.reloadData()
    }
}

//MARK: - Keyboard

extension ConversationViewController {
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        print(view.frame.origin.y)
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            additionalSafeAreaInsets.bottom = keyboardSize.height
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        additionalSafeAreaInsets.bottom = CGFloat.zero
    }
}

//
//  ChatViewController.swift
//  Chat
//
//  Created by Alessandro Schioppetti on 02/04/2020.
//  Copyright © 2020 Codermine Srl. All rights reserved.
//

import UIKit

class ChatViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "C H A T"
        navigationItem.hidesBackButton = true
        let logOutButton = UIBarButtonItem(title: "Log out",
                                           style: .plain,
                                           target: self,
                                           action: #selector(logOutButtonTouched(_:)))
        navigationItem.rightBarButtonItems = [logOutButton]
        
        tableView.dataSource = self
        
        tableView.registerNib(MessageCell.self)
        
        loadMessages()
        
    }
    
    func loadMessages() {
        
        MessageService.shared.loadMessages(for: 0) { result in
            
            switch result {
            case .success(let messages):
                self.messages = messages
                if self.messages.count > 0 {
                    self.tableView.reloadData()
                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            
        }
    }
    
    @IBAction func sendButtonTouchUp(_ sender: UIButton) {
        //MessageService.shared.sendMessage(messageBody, completion: nil) - optional completion
        if let messageBody = messageTextField.text {
            MessageService.shared.sendMessage(messageBody) { result in
                switch result {
                case .success(let output):
                    print(output)
                    self.messageTextField.text = ""
                case .failure(let e):
                    print(e)
                }
            }
        }
        
    }
    
    
    @objc
    func logOutButtonTouched(_ sender: UIBarButtonItem) {
        SessionService.shared.LogOut() { signOutError in
            if let error = signOutError {
                print ("Error signing out: %@", error)
            } else {
                print("Sign out correctly.")
                navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    
}

//MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueClass(MessageCell.self, for: indexPath)
        if let messageSender = messages[indexPath.row].sender, let messageBody = messages[indexPath.row].body {
            cell.configure(messageSender, messageBody)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
}

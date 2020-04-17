//
//  MessageCell.swift
//  Chat
//
//  Created by Alessandro Schioppetti on 03/04/2020.
//  Copyright © 2020 Codermine Srl. All rights reserved.
//

import UIKit
import Firebase

class MessageCell: UITableViewCell {

    static var prova = "ciaoooo"
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(_ messageSender: String, _ messageBody: String) {
        label.text = messageBody
        if messageSender == Auth.auth().currentUser?.email {
            leftImageView.isHidden = true
            rightImageView.isHidden = false
            messageBubble.backgroundColor = .purple
            label.textColor = .white
        } else {
            leftImageView.isHidden = false
            rightImageView.isHidden = true
            messageBubble.backgroundColor = .lightGray
            label.textColor = .purple
        }
    }
    
}

//
//  Message.swift
//  Chat
//
//  Created by Alessandro Schioppetti on 03/04/2020.
//  Copyright © 2020 Codermine Srl. All rights reserved.
//

import Foundation

struct Message {
    let sender: String?
    let body: String?
    
    init(_ dictionary: Dictionary<String, Any>) {
        body = dictionary["body"] as? String
        sender = dictionary["sender"] as? String
    }
}

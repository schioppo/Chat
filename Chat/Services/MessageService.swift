//
//  MessageService.swift
//  Chat
//
//  Created by Alessandro Schioppetti on 07/04/2020.
//  Copyright © 2020 Codermine Srl. All rights reserved.
//

import Foundation
import Firebase

protocol MessageServiceProtocol {
    func loadMessages(for page: Int, completion: @escaping MessagesCompletion)
    func sendMessage(_ messageBody: String, completion: sendMessageCompletion)
}

enum MessageError: Error {
    case noDoments
}

typealias MessagesCompletion = (Result<[Message], Error>) -> ()
typealias sendMessageCompletion = ((Result<String, Error>) -> ())?

class MessageService: MessageServiceProtocol {
    
    static let shared: MessageService = MessageService()
    lazy var db = Firestore.firestore()

    func loadMessages(for page: Int, completion: @escaping MessagesCompletion) {
        db.collection("messages")
            .order(by: "data")
            .addSnapshotListener { (QuerySnapshot, Error) in
                
                var messages = [Message]()
                
                if let e = Error {
                    DispatchQueue.main.async {
                        completion(Result.failure(e))
                    }
                } else {
                    if let snapShotDocuments = QuerySnapshot?.documents {
                        for doc in snapShotDocuments {
                            let data = doc.data()
                            messages.append(Message(data))
                        }
                        DispatchQueue.main.async {
                            completion(Result.success(messages))
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(.failure(MessageError.noDoments))
                        }
                    }
                }
        }
    }
    
    func sendMessage(_ messageBody: String, completion: sendMessageCompletion) {
    
        if let messageSender = Auth.auth().currentUser?.email {
            db.collection("messages").addDocument(data: [
                "body": messageBody,
                "sender": messageSender,
                "data": Date().timeIntervalSince1970
            ]) { (error) in
                guard let completion = completion else { return }
                if let e = error {
                    DispatchQueue.main.async {
                        completion(.failure(e))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.success("Data correctly saved on firebase."))
                    }
                }
            }
        }
    }
    
    
    
}

//
//  SessionService.swift
//  Chat
//
//  Created by Alessandro Schioppetti on 09/04/2020.
//  Copyright © 2020 Codermine Srl. All rights reserved.
//

import Foundation
import Firebase

protocol SessionProtocol {
    func LogIn(_ email: String, _ password: String, completion: @escaping SessionCompletion)
    func LogOut(completion: SessionCompletion)
    func Register(_ email: String, _ password: String, completion: @escaping SessionCompletion)
}

typealias SessionCompletion = (Error?) -> Void

class SessionService: SessionProtocol {
    
    static let shared: SessionService = SessionService()
    
    func LogIn(_ email: String, _ password: String, completion: @escaping SessionCompletion) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                DispatchQueue.main.async {
                    completion(e)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        
    }
    
    func LogOut(completion: SessionCompletion) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let signOutError as NSError {
            completion(signOutError)
        }
    }


    func Register(_ email: String, _ password: String, completion: @escaping SessionCompletion) {
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                DispatchQueue.main.async {
                    completion(e)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    
}

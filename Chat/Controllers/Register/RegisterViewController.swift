//
//  RegisterViewController.swift
//  Chat
//
//  Created by Alessandro Schioppetti on 02/04/2020.
//  Copyright © 2020 Codermine Srl. All rights reserved.
//

import UIKit
import MBProgressHUD

class RegisterViewController: BaseViewController {
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        mailTextField.delegate = self
//        passwordTextField.delegate = self
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    @IBAction func confirmRegistrationTouchUp(_ sender: UIButton) {
        
        if let email = mailTextField.text, let pw = passwordTextField.text {
            if isValidEmail(email) {
                MBProgressHUD.showAdded(to: self.view, animated: true)
                SessionService.shared.Register(email, pw) { registrationError in
                    if let error = registrationError {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        print(error.localizedDescription)
                    } else {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        print("registration succesfully.")
                        let controller = ChatViewController(nibName: "ChatViewController", bundle: nil)
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                }
            } else {
                print("email is not valid")
              }
        }
        
    }
    
    
}

//MARK: - UItextFieldDelegate

//extension RegisterViewController: UITextFieldDelegate {
//
//        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//            textField.endEditing(true)
//            return true
//        }
//
//        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//            print(#function)
//            if textField.text != "" {
//                return true
//            } else {
//                return false
//            }
//        }
//
//        func textFieldDidEndEditing(_ textField: UITextField) {
//            print(#function, "end editing")
//        }
//
//}

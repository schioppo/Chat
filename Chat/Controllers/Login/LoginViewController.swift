//
//  LoginViewController.swift
//  Chat
//
//  Created by Alessandro Schioppetti on 03/04/2020.
//  Copyright © 2020 Codermine Srl. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logInButtonTouchUp(_ sender: UIButton) {
        
        if let email = mailTextField.text, let password = passwordTextField.text {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            SessionService.shared.LogIn(email, password) { error in
                if let e = error {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    print(e.localizedDescription)
                } else {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let controller = ChatViewController(nibName: "ChatViewController", bundle: nil)
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
            
            
        }
        
    }
    
    
    
}

//
//  WelcomeViewController.swift
//  Chat
//
//  Created by Alessandro Schioppetti on 02/04/2020.
//  Copyright © 2020 Codermine Srl. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: BaseViewController {
    
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Choose"
    }
    
    @IBAction func registerButtonTouchUp(_ sender: UIButton) {
        let controller = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func loginButtonTouchUp(_ sender: UIButton) {
        let controller = LoginViewController(nibName: "LoginViewController", bundle: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
}

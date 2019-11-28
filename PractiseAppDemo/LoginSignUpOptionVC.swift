//
//  LoginSignUpOptionVC.swift
//  PractiseAppDemo
//
//  Created by Dheeraj Arora on 08/08/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit

class LoginSignUpOptionVC: UIViewController {
    

    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btnSignUp.layer.cornerRadius = 5
        btnSignUp.layer.borderWidth = 1
        
        btnLogin.layer.cornerRadius = 5
        btnLogin.layer.borderWidth = 1
    }
    

   
    @IBAction func goToSignUpAction(_ sender: Any) {
        let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
        self.navigationController?.pushViewController(loginVC, animated: false)
    }
    
    @IBAction func goToLoginAction(_ sender: Any) {
        let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
        self.navigationController?.pushViewController(loginVC, animated: false)
    }
}

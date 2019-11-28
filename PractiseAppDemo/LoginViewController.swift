//
//  LoginViewController.swift
//  PractiseAppDemo
//
//  Created by Dheeraj Arora on 08/08/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtEmail: UITextField!{
        didSet {
//          txtEmail.tintColor = UIColor.gray
            txtEmail.setIcon(UIImage(named: "email_icon")!)
            
        }
    }
    
    @IBOutlet weak var txtPassword: UITextField!{
        didSet {
            //txtPassword.tintColor = UIColor.lightGray
            txtPassword.setIcon(UIImage(named: "password_icon")!)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogin.layer.cornerRadius = 5
        btnLogin.layer.borderWidth = 1
        setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func setUpView() {
        txtEmail.becomeFirstResponder()
        
        //listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:   #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.hideKeyboardTappedOutside()
    }
    @objc func keyboardWillChange(notification:Notification)
    {
        guard let heightRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == UIResponder.keyboardWillShowNotification
        {
            view.frame.origin.y = -heightRect.height + 160
        }else{
            view.frame.origin.y = 0
        }
        
    }
    deinit {
        //stop listening for keyboard hide/show events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @IBAction func goToNext(_ sender: UIButton) {
        validation()
    }
    
    func validation() {
        if txtEmail.text!.isEmpty{
            SharedClass.sharedInstance.alert(view: self, title: "Enter Email", message: "Please enter email address")
        }
        else if self.validateEmail(strEmail: txtEmail.text!) {
           SharedClass.sharedInstance.alert(view: self, title: "Invalid email address", message: "Please Enter Valide email address")
        }
        else if (txtPassword.text?.isEmpty)! {
            SharedClass.sharedInstance.alert(view: self, title: "Enter Password", message: "Please Enter Password")
        }
        else if !self.isValidPassword(strPassword: txtPassword.text!) {
            SharedClass.sharedInstance.alert(view: self, title: "Invalide Password", message: "Please Enter valide Password")
        }
       else{
            UserDefaults.standard.set(txtEmail.text!, forKey: "mobileNumber")
            let nextVC = self.storyboard!.instantiateViewController(withIdentifier: "EnterOtpVC") as! EnterOtpVC
            nextVC.otp = "1234"
            self.navigationController?.pushViewController(nextVC, animated: false)
        }
    }
    
    func validateEmail(strEmail: String) -> Bool {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: strEmail)
    }
    func isValidPassword(strPassword:String?) -> Bool {
        guard strPassword != nil else { return false }
        
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: strPassword)
    }

}
extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}

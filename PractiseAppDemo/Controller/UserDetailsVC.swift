//
//  UserDetailsVC.swift
//  PractiseAppDemo
//
//  Created by Dheeraj Arora on 29/07/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit

class UserDetailsVC: UIViewController {
    

    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtReferralCode: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var lblInfoTitle: UILabel!
    var email = "naresh1214@gmail.com"
   
    override func viewDidLoad() {
       
        super.viewDidLoad()
        setUpView()
        let mobileNumber = UserDefaults.standard.object(forKey: "mobileNumber" )
        lblInfoTitle.text = "\(lblInfoTitle.text ?? "")\(+91)\(String(describing: mobileNumber!))"
         addCustomizedBackBtn()
    }
    
    func setUpView() {
        btnRegister.layer.cornerRadius = btnRegister.frame.height/2
        txtFullName.becomeFirstResponder()
        
        //listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.hideKeyboardTappedOutside()
    }
    @objc func keyboardWillChange(notification:Notification)
    {
        guard let heightRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == UIResponder.keyboardWillShowNotification
        {
            view.frame.origin.y = -heightRect.height + 200
        }else{
            view.frame.origin.y = 0
        }
        
    }
    deinit {
        //stop listening for keyboard hide/show events
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @IBAction func btnRegisterAction(_ sender: UIButton) {
        validation()
    }
    func validation() {

        if txtFullName.text!.isEmpty{
            SharedClass.sharedInstance.alert(view: self, title: "Full Name required", message: "Full name can't be Blank")
            
        }
        else if (txtFullName.text?.count)! < 4  && (txtFullName.text?.count)! != 30
        {
            SharedClass.sharedInstance.alert(view: self, title: "Full Name ", message: "Full name Must Be in Between 5 to 30 characters")
        }
            
        else if isValidEmail(emailID:txtEmail.text!)  == false
        {
            SharedClass.sharedInstance.alert(view: self, title: "Email Correction ", message: "Please enter valide email address")
        }
        else
        {
            UserDefaults.standard.set(txtFullName.text, forKey: "username")
            let goToDashboardVC = self.storyboard!.instantiateViewController(withIdentifier: "UserDashboard") as! UserDashboard
            self.navigationController?.pushViewController(goToDashboardVC, animated: false)        }
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)

    }
        func isValidEmail(emailID:String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: emailID)
        }
}

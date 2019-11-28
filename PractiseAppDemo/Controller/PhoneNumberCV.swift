//
//  PhoneNumberCV.swift
//  PractiseAppDemo
//
//  Created by Dheeraj Arora on 26/07/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit

class PhoneNumberCV: UIViewController {
    
    
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtFlagCountryCode: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    var isUserLogin:Bool?
//    var mobileNumber = "9872948876"

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpView()
        addCustomizedBackBtn()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func setUpView() {
        btnNext.layer.cornerRadius = btnNext.frame.height/2
        txtMobileNumber.becomeFirstResponder()
        
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
    
    @IBAction func goToNext(_ sender: UIButton) {
        validation()
    }
    
    func validation() {
        if txtMobileNumber.text!.isEmpty{
            SharedClass.sharedInstance.alert(view: self, title: "Mobile Number", message: "Please enter mobile number")
        }
        else if txtMobileNumber.text!.count != 10{
            SharedClass.sharedInstance.alert(view: self, title: "Mobile Number", message: "Please enter 10 digit mobile number")
            
        }
//        else if isValidePhoneNumber(value: txtMobileNumber.text!) == false{
//            SharedClass.sharedInstance.alert(view: self, title: "Mobile Number", message: "Please enter valide mobile number")
//
//        }
        else{
            UserDefaults.standard.set(txtMobileNumber.text, forKey: "mobileNumber")
            let nextVC = self.storyboard!.instantiateViewController(withIdentifier: "EnterOtpVC") as! EnterOtpVC
            nextVC.otp = "1234"
            self.navigationController?.pushViewController(nextVC, animated: false)
        }
    }
    @IBAction func btnBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    func isValidePhoneNumber(value: String) -> Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,10}$";    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
}

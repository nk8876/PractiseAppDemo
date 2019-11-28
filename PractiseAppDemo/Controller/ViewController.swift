//
//  ViewController.swift
//  PractiseAppDemo
//
//  Created by Dheeraj Arora on 26/07/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtFlagCountryCode: UITextField!
    var mobileNumber = "9872948876"
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        addCustomizedBackBtn()

       
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func goToNextVC(textField: UITextField) {
        let nextVC = self.storyboard!.instantiateViewController(withIdentifier: "PhoneNumberCV") as! PhoneNumberCV
        self.navigationController!.pushViewController(nextVC, animated: false)
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtMobileNumber{
            return false //do not show keyboard nor cursor
        }
        if textField == txtFlagCountryCode{
            return false //do not show keyboard nor cursor
        }
        return true
    }

    func setUpView() {
        txtMobileNumber.delegate = self
        txtMobileNumber.addTarget(self, action: #selector(goToNextVC), for: .touchDown)
       
    }
   
}




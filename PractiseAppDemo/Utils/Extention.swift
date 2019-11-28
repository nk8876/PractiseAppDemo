//
//  Utils.swift
//  WebSevicesUsingURLSession
//
//  Created by Dheeraj Arora on 16/07/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  
    func addCustomizedBackBtn() {
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back_button2")
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back_button2")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
    }
   
    func hideKeyboardTappedOutside()  {
        let showKeyboard:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(showKeyboard)
    }
    
    @objc func DismissKeyboard()  {
        view.endEditing(true)
    }
   
    
}

extension String{
   
    func isValidEmail(strEmail:String) -> Bool {
        print("validate emilId: \(strEmail)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: strEmail)
        return result
    }
    
    func isValidPincode(value: String) -> Bool {
        if value.characters.count == 6{
            return true
        }
        else{
            return false
        }
    }
}

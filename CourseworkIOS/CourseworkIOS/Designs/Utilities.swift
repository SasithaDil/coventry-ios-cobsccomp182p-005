//
//  Utilities.swift
//  customauth
//
//  Created by Christopher Ching on 2019-05-09.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func textFieldStyles(_ textfield:UITextField) {
        

        let bottomLine = CALayer()

        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)

        bottomLine.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 51/255, alpha: 1).cgColor

        textfield.borderStyle = .none

        textfield.layer.addSublayer(bottomLine)
        textfield.layer.cornerRadius = 10
        textfield.tintColor = UIColor.gray
        
        
    }
    
    static func buttonStyles(_ button:UIButton) {
        
        button.backgroundColor = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        button.layer.cornerRadius = 10.0
        button.tintColor = UIColor.white
        
        
    }
    static func buttonStylesDefault(_ button:UIButton) {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.init(red: 99/255, green: 99/255, blue: 102/255, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        button.tintColor = UIColor.black
        
        
    }
    static func buttonStylesCancel(_ button:UIButton) {
       
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        button.tintColor = UIColor.black
    }
    
    func isValidEmail(_ email: String) -> Bool {
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailPred.evaluate(with: email)
    }

    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
}

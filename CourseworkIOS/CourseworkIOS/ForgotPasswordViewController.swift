//
//  ForgotPasswordViewController.swift
//  CourseworkIOS
//
//  Created by Sasitha Dilshan on 2/25/20.
//  Copyright © 2020 Sasitha Dilshan. All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {

    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet var emailContainerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

       setupElements()
    }
    func setupElements(){
        Utilities.textFieldStyles(txtEmail)
        Utilities.buttonStylesCancel(btnCancel)
        Utilities.buttonStyles(btnReset)
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        lblError.alpha = 0
    }

    @IBAction func resetPassword(_ sender: Any) {
        let validEmail = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if validEmail == ""{
            lblError.text = "Enter your email address"
            lblError.alpha = 1
        }else{
            Auth.auth().sendPasswordReset(withEmail: txtEmail.text!, completion: { (error) in
                if error != nil{
                    if error == nil{
                        let alert = UIAlertController(title: "Successful..", message: "You have changed your password..", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                        
                    }
                    else{
                        self.lblError.text = error!.localizedDescription
                        self.lblError.alpha  = 1
                    }
                }
                
                
            }
            )}
        }
    }



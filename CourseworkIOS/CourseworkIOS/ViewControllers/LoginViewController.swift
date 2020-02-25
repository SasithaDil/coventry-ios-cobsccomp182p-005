//
//  LoginViewController.swift
//  CourseworkIOS
//
//  Created by Sasitha Dilshan on 2/11/20.
//  Copyright © 2020 Sasitha Dilshan. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupElements()
    }
    
    func setupElements(){
        lblError.alpha = 0
        
        Utilities.buttonStyles(btnLogin)
        Utilities.textFieldStyles(txtEmail)
        Utilities.textFieldStyles(txtPassword)
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func LOgin(_ sender: Any) {
        view.endEditing(true)

        
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (result, error) in
            
            if error != nil{
                self.lblError.text = error!.localizedDescription
                self.lblError.alpha  = 1
            }
            else{
                self.performSegue(withIdentifier: "HomeVC", sender: nil)
            }
        }
    }
    
}

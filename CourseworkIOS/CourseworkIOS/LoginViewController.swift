//
//  LoginViewController.swift
//  CourseworkIOS
//
//  Created by Sasitha Dilshan on 2/11/20.
//  Copyright © 2020 Sasitha Dilshan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupElements()
    }
    
    func setupElements(){
        Utilities.buttonStyles(btnLogin)
        Utilities.textFieldStyles(txtEmail)
        Utilities.textFieldStyles(txtPassword)
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    }
   
}

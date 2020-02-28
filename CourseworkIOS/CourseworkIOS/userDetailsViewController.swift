//
//  userDetailsViewController.swift
//  CourseworkIOS
//
//  Created by Sasitha Dilshan on 2/28/20.
//  Copyright © 2020 Sasitha Dilshan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class userDetailsViewController: UIViewController {

    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    var pst:Post!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
        setupElements()
    }
    func setupElements(){
        imgUser.layer.cornerRadius = imgUser.frame.size.width/2
        imgUser.clipsToBounds = true
        imgUser.layer.borderColor = UIColor.blue.cgColor
        imgUser.layer.borderWidth = 5
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    }
    func loadData(){
        
        let usrImg = pst.userImageURL
        
        let profImageUrl = URL(string: usrImg)!
        let profImageData = try! Data(contentsOf: profImageUrl)
        let profImage = UIImage(data: profImageData)
        
        self.imgUser.image = profImage
        
        
        self.Name.text = pst.user
        
        let usrid = pst.userID
        
         Database.database().reference().child("User").child(usrid).observe(.value) { (snapshot: DataSnapshot) in
        
            let dict = snapshot.value as? [String: Any]
            let contactNum = dict!["ContactNumber"] as? String
            let mail = dict!["Email"] as? String
            
            self.contact.text = "Contact Number : "+contactNum!
            
            self.email.text = "Email : "+mail!
            
            
            
            
    }

    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

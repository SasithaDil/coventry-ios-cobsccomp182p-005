//
//  ProfileViewController.swift
//  CourseworkIOS
//
//  Created by Sasitha Dilshan on 2/13/20.
//  Copyright © 2020 Sasitha Dilshan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class ProfileViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tableVire: UITableView!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupElements()
        loadImg()
        
    }
    func setupElements(){
        profPic.layer.cornerRadius = profPic.frame.size.width/2
        profPic.clipsToBounds = true
        profPic.layer.borderColor = UIColor.blue.cgColor
        profPic.layer.borderWidth = 5
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        
    }
    
    @IBAction func Logout(_ sender: Any) {
        
        try! Auth.auth().signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC")
            self.present(vc, animated: false, completion: nil)
        }
        
    }
    
    func loadImg(){
        
        let id = Auth.auth().currentUser?.uid
        
        //        ref.child("User").child(id!).observe(.childAdded) { (snapshot: DataSnapshot) in
        //        print(id!)
        //            Database.database().reference().child("User").child(id!).observe(.childAdded){ (snapshot) in
        
        Database.database().reference().child("User").child(id!).observe(.value) { (snapshot: DataSnapshot) in
            
            print(snapshot.value!)
            
            let dict = snapshot.value as? [String: Any]
            let fname = dict!["FirstName"] as? String
            let lname = dict!["LastName"] as? String
            let mail = dict!["Email"] as? String
            let contactNum = dict!["ContactNumber"] as? String
            let profImage = dict!["ProfilePicURL"] as? String
            
            
            let imageUrl = URL(string: profImage!)
            let imageData = try! Data(contentsOf: imageUrl!)
            let image = UIImage(data: imageData)
            
            
            self.profPic.image = image!
            self.name.text = " Name : " + fname!+" "+lname!
            self.email.text = "Email : " + mail!
            self.contact.text = "Contact Number : " + contactNum!
            
            
            
        }
        
    }
}

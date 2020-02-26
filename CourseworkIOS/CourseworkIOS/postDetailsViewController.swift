//
//  postDetailsViewController.swift
//  CourseworkIOS
//
//  Created by Sasitha Dilshan on 2/26/20.
//  Copyright © 2020 Sasitha Dilshan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class postDetailsViewController: UIViewController {

    
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var lblcaption: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
//    var UID: String?
     var post: Post!
    var c = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
        setupElements()
    }
    
    func setupElements(){
        Utilities.buttonStyles(btnYes)
        Utilities.buttonStylesCancel(btnNo)
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        imgUser.layer.cornerRadius = imgUser.frame.size.width/2
        imgUser.clipsToBounds = true
        imgUser.layer.borderColor = UIColor.blue.cgColor
        imgUser.layer.borderWidth = 5
    }
    
    func loadData(){
        self.lblName.text = post.user
        self.lblcaption.text = post.caption
        self.lblDate.text = post.eventDate
        self.lblTime.text = post.eventTime
        
        let usrImg = post.userImageURL
        
        let profImageUrl = URL(string: usrImg)!
        let profImageData = try! Data(contentsOf: profImageUrl)
        let profImage = UIImage(data: profImageData)
      
        self.imgUser.image = profImage
        
        let x = post.imgURL
        
        let imageUrl = URL(string: x)!
        let imageData = try! Data(contentsOf: imageUrl)
        let imageP = UIImage(data: imageData)
        
        self.imgPost.image = imageP
        
    }

    @IBAction func btnParticipate(_ sender: Any) {
        
        let id = Auth.auth().currentUser?.uid
        
        if id != post.userID {
        c = c + 1;
        self.count.text = "Participants count : \(c)"
        }
    }
    
    @IBAction func btnNotParticipate(_ sender: Any) {
//        let homeViewController =  self.storyboard?.instantiateViewController(withIdentifier: Redirect.StoryBoard.homeViewController) as? HomeViewController
//        
//        self.view.window?.rootViewController = homeViewController
//        self.view.window?.makeKeyAndVisible()
    }
    

}


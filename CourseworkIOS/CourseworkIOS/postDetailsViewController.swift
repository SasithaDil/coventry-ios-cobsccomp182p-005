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
    
    
    @IBOutlet weak var btnCancel: UIButton!
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
    
    let ref = Database.database().reference()
    let id = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgUser.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.guesture))
        tap.numberOfTapsRequired = 1
        imgUser.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        loadData()
        setupElements()
        getCount()
    }
    @objc func guesture(){
        
        let vc = userDetailsViewController()
//        let selectedPost = post.userID
        vc.pst = post
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
//        dismiss(animated: true, completion: nil)
       
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
    
    func  getCount(){
        
        ref.child("EventsParticipants/\(self.post.id)/participants/").observe(.value) { (snapshot: DataSnapshot) in
            
            print(snapshot.value!)
            
            let dict = snapshot.value as? [String: Any]
            
            //            let IDofPost = dict!["postID"] as? String
            
            let c = dict?.count
            
            self.count.text = "Participant Count :\(c ?? 0)"
            
        }
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
        
        
        let PostUID = self.post.userID
        
        ref.child("User").child(id!).observe(.value) { (snapshot: DataSnapshot) in
            
            
            let dict = snapshot.value as? [String: Any]
            let fname = dict!["FirstName"] as? String
            let lname = dict!["LastName"] as? String
            let mail = dict!["Email"] as? String
            let contactNum = dict!["ContactNumber"] as? String
            let profImage = dict!["ProfilePicURL"] as? String
            let user = dict!["uid"] as? String
            
            let data = ["username":fname! + " " + lname!, "email": mail,"phoneNumber": contactNum,"userImg":profImage,"uid": user, "postID": self.post.id]
            
            if self.id != PostUID {
                
                self.ref.child("EventsParticipants/\(self.post.id)/participants/\(self.id!)").observe(.value) { (snapshotE: DataSnapshot) in

                    
                    let dictE = snapshotE.value as? [String: Any]
                    let participantId = dictE?["uid"] as? String
                    
                    

                    
                        if self.id != participantId {
                        
                            self.ref.child("EventsParticipants").child(self.post.id).child("participants").child(self.id!).setValue(data)
                            
                            let alert = UIAlertController(title: "Successfull", message: "", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true)
                            
                        }else{
                            
                            let alert = UIAlertController(title: "", message: "You have already in participants list", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true)
                        }
        
                }
            }
            else{
                let alert = UIAlertController(title: "Error", message: "You have already participate the event", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
        
    }
    @IBAction func btnNotParticipate(_ sender: Any) {
        
        self.ref.child("EventsParticipants/\(self.post.id)/participants/\(self.id!)").observe(.value) { (snapshotE: DataSnapshot) in
            
            print(snapshotE.value!)
            
            let dictE = snapshotE.value as? [String: Any]
            let participantId = dictE?["uid"] as? String
            
            
            if participantId != nil && participantId == self.id{
        
               self.ref.child("EventsParticipants/\(self.post.id)/participants/\(self.id!)").removeValue()
            }
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


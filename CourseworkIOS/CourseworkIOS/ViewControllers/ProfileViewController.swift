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
import FirebaseStorage
import LocalAuthentication

class ProfileViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var MypostsTableView: UITableView!
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tableVire: UITableView!
    
    var myPosts  = [Post]()
    var ref: DatabaseReference!
    var id = Auth.auth().currentUser?.uid
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupElements()
        loadImg()
        loadMyPost()
        CheckFaceID()
        
        
    }
    func setupElements(){
        profPic.layer.cornerRadius = profPic.frame.size.width/2
        profPic.clipsToBounds = true
        profPic.layer.borderColor = UIColor.blue.cgColor
        profPic.layer.borderWidth = 5
//        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
       
        
    }

    @objc fileprivate func CheckFaceID(){
        
        let context = LAContext()
        
        var error : NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            
            let reason = "identify your self"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){
                
                [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success{
                        //                        self!.dismiss(animated: true, completion:nil)
                    }else{
                        
                        let ac = UIAlertController(title: "Authentication failed", message: "You could Not be verified, Please Try again", preferredStyle: .alert)
                        
                        ac.addAction(UIAlertAction(title: "ok", style: .default))
                        self?.present(ac , animated: true)
                        
                    }
                }
            }
        }else{
            
            let ac = UIAlertController(title: "Biometry UNavailable", message: "not configures", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .default))
            present(ac , animated: true)
        }
        
    }

    @IBAction func Logout(_ sender: Any) {
        
        try! Auth.auth().signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC")
            self.present(vc, animated: false, completion: nil)
        }
        
    }
    
    
    func loadImg(){
        
        
        
        Database.database().reference().child("User").child(id!).observe(.value) { (snapshot: DataSnapshot) in
            
           
            
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
    
    func loadMyPost(){
        
        Database.database().reference().child("Posts").observe(.childAdded) { (snapshotP: DataSnapshot) in
            
//                            print(Thread.isMainThread)
            
            if let dict = snapshotP.value as? [String: Any]{
                let captionText = dict["caption"] as! String
                let imagePath = dict["imgURL"] as! String
                let profPicture = dict["profPic"] as! String
                let username = dict["username"] as! String
                let postID = dict["postID"] as! String
                let eventDate = dict["eventDate"] as! String
                let eventTime = dict["startingTime"] as! String
                let userId = dict["uid"] as! String
                
                if userId == self.id{
                
                let post = Post(captionText: captionText, imagePath: imagePath, userDetails: username, userPic: profPicture, postId: postID, date: eventDate, time: eventTime, uid: userId)
                //                self.posts.append(post)
                self.myPosts.insert(post, at: 0)
                //                    print(self.posts)
                self.MypostsTableView.reloadData()
                
                }
                
            }
        }
    }
}

extension ProfileViewController: UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myPostCell", for: indexPath) as? MyPostsTableViewCell
        
        myCell?.postCaption.text = myPosts[indexPath.row].caption
        
        
        let capImg = myPosts[indexPath.row].imgURL
        
        let imageUrl = URL(string: capImg)!
        let imageData = try! Data(contentsOf: imageUrl)
        let image = UIImage(data: imageData)
        
        myCell?.postImage.image = image
        myCell?.layer.backgroundColor = UIColor.clear.cgColor
        return myCell!
    }
    
    
}
extension ProfileViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row at : \(indexPath)")
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyPostDetailViewController") as? MyPostDetailViewController
        vc?.idx = myPosts[indexPath.row].id
        present(vc!, animated: true, completion: nil)
        

    }
}

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
    var pic  = profile(profImg: "", name: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        loadImg()

    }
    func setupElements(){
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
        Database.database().reference().child("Users").observe(.childAdded) { (snapshot: DataSnapshot) in
            //                print(Thread.isMainThread)
            if let dict = snapshot.value as? [String: Any]{
                let picture = dict["ProfilePicURL"] as! String
                let uname = dict["FirstName"] as! String
                
                
                let photo = profile(profImg: picture, name: uname)
                self.pic = photo
                //                    print(self.posts)
//                self.tableView.reloadData()
    }
    
        }
        
    }
}
extension ProfileViewController: UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
       
         let x = pic.profilePic
        
        let imageUrl = URL(string: x)!
        let imageData = try! Data(contentsOf: imageUrl)
        let image = UIImage(data: imageData)
        profPic?.image = image
       
        dismiss(animated: true, completion: nil)
    }
    
        
    
}

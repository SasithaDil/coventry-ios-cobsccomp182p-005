//
//  MyPostDetailViewController.swift
//  CourseworkIOS
//
//  Created by Sasitha Dilshan on 2/28/20.
//  Copyright © 2020 Sasitha Dilshan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import ImagePicker

class MyPostDetailViewController: UIViewController {
    
    
    @IBOutlet weak var updateTime: UITextField!
    @IBOutlet weak var updateDate: UITextField!
    @IBOutlet weak var Update: UIButton!
    //    @IBOutlet weak var Time: UILabel!
    //    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var postCaption: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    
    var idx = ""
    
    var ref = Database.database().reference()
    var myPosts: Post!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPostData()
        // Do any additional setup after loading the view.
    }
    
    func loadPostData(){
        
        
        //
        //        let pid = myPosts
        //        print(pid!)
        let x = self.idx
        
        //        let x  = MyPostData.caption
        //        print(x)
        //        postCaption?.text = x
        ref.child("Posts").child(x).observe(.value) { (snapshot: DataSnapshot) in
            
            let dict = snapshot.value as? [String: Any]
            let captionText = dict!["caption"] as! String
            let imagePath = dict!["imgURL"] as! String
            let eventDate = dict!["eventDate"] as! String
            let eventTime = dict!["startingTime"] as! String
            
            self.postCaption.text = captionText
            self.updateDate.text = eventDate
            self.updateTime.text = eventTime
            
            let imageUrl = URL(string: imagePath)
            let imageData = try! Data(contentsOf: imageUrl!)
            let image = UIImage(data: imageData)
            
            self.postImage.image = image
        }
        
    }
    
    
    @IBAction func buttonUpdate(_ sender: Any) {
        
                    let data = [
//                        "imgURL": pic as Any,
                        "caption": self.postCaption.text!,
                        "eventDate": self.updateDate.text!,
                        "startingTime": self.updateTime.text!,
                        "postDate": ServerValue.timestamp()] as [String : Any]
                    
                    self.ref.child("Posts").child(self.idx).updateChildValues(data)
        
        let alert = UIAlertController(title: "Updated Successfuly..", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)

        
    }
}

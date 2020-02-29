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

class MyPostDetailViewController: UIViewController {

  
    @IBOutlet weak var Update: UIButton!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var postCaption: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    
    var idx = ""
    
    
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
        print(x)
//        let x  = MyPostData.caption
//        print(x)
//        postCaption?.text = x
        Database.database().reference().child("Posts").observe(.childAdded) { (snapshot: DataSnapshot) in

                let dict = snapshot.value as? [String: Any]
                let captionText = dict!["caption"] as! String
//                let imagePath = dict["imgURL"] as! String
//            print(captionText)
            self.postCaption.text = captionText


            }

    }
    

    @IBAction func buttonUpdate(_ sender: Any) {

    }
}


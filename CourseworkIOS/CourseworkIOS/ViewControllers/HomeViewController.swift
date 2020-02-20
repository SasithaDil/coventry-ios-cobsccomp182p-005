//
//  HomeViewController.swift
//  CourseworkIOS
//
//  Created by Sasitha Dilshan on 2/12/20.
//  Copyright © 2020 Sasitha Dilshan. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabase


class HomeViewController: UIViewController {

    
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var tableView: UITableView!
//
    var ref: DatabaseReference!
    var DatabaseHandle: DatabaseHandle!
    var posts  = [Post]()
//    var postData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        loadPosts()
        setupElements()
        
//        let post = Post(captionText: "test", imagePath: "url1")
//        print(post.caption)
//        print(post.imgURL)
    }
    
    func setupElements(){
        
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
       
    }
    func loadPosts(){
        
        
            Database.database().reference().child("Posts").observe(.childAdded) { (snapshot: DataSnapshot) in
//                print(Thread.isMainThread)
                if let dict = snapshot.value as? [String: Any]{
                    let captionText = dict["caption"] as! String
                    let imagePath = dict["imgURL"] as! String

                    
                    let post = Post(captionText: captionText, imagePath: imagePath)
                    self.posts.append(post)
//                    print(self.posts)
                    self.tableView.reloadData()
                }
        
        }
   
       }
    
    }



extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
       
        cell.textLabel?.text = posts[indexPath.row].caption
        
        let x = posts[indexPath.row].imgURL
        
        let imageUrl = URL(string: x)!
        let imageData = try! Data(contentsOf: imageUrl)
        let image = UIImage(data: imageData)
        cell.imageView?.image = image
        cell.backgroundColor = UIColor.clear
        return cell
        
    }
}

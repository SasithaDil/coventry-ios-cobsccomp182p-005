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
import Alamofire


class HomeViewController: UIViewController {


    

    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    var DatabaseHandle: DatabaseHandle!
     var posts  = [Post]()
//    var postData = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.dataSource = self as? UITableViewDataSource
        
        loadPosts()
        setupElements()
        setupTableView()
        
//        let post = Post(captionText: "test", imagePath: "url1")
//        print(post.caption)
//        print(post.imgURL)
    }
    
    func setupElements(){
        
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
       
    }
    func setupTableView(){
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PostCell")
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
//                    print(self.posts)
//                    self.tableView.reloadData()
                    
//                    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//                        return self.posts.count
//                    }
//
//                    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//                        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as UITableViewCell
//
////                        self.captiontxt?.text = self.posts[indexPath.row].caption
//
//                        let x = self.posts[indexPath.row].imgURL
//
//                        let imageUrl = URL(string: x)!
//                        let imageData = try! Data(contentsOf: imageUrl)
//                        let image = UIImage(data: imageData)
//                        cell.imageView?.image = image
//                        cell.backgroundColor = UIColor.clear
//                        return cell
//
//                    }
                }
        
        }
   
       }
    
    }



extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! CustomTableViewCell

        cell.captiontext?.text = posts[indexPath.row].caption

        let x = posts[indexPath.row].imgURL

        let imageUrl = URL(string: x)!
        let imageData = try! Data(contentsOf: imageUrl)
        let image = UIImage(data: imageData)
        cell.imagePOST?.image = image
        cell.backgroundColor = UIColor.clear
        return cell

    }
}

extension HomeViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row at : \(indexPath)")
    }
}

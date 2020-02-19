//
//  UploadViewController.swift
//  CourseworkIOS
//
//  Created by Sasitha Dilshan on 2/13/20.
//  Copyright © 2020 Sasitha Dilshan. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabase


class UploadViewController: UIViewController {

    @IBOutlet weak var btnTrash: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var photo: UIImageView!
    
    var selectedImage: UIImage!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupElements()
        ImageUpload()
        
        
        
    }
    func setupElements(){
        Utilities.buttonStyles(btnShare)
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func ImageUpload(){
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(UploadViewController.handleSelectPhoto))
        photo.addGestureRecognizer(tapGuesture)
        photo.isUserInteractionEnabled = true
    }
    
    @objc func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self 
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func Remove_post(_ sender: Any) {
        self.caption.text = ""
        self.photo.image = UIImage(named: "icons8-pictures-folder-100")
        
    }
    
    @IBAction func Share(_ sender: Any) {
        if let postImg = self.selectedImage, let imageData = postImg.jpegData(compressionQuality: 0.1){
            let photoID = NSUUID().uuidString
            let storageRef = Storage.storage().reference(forURL: "gs://coursework-ios-730cb.appspot.com").child("Posts").child(photoID)
            storageRef.putData(imageData, metadata: nil, completion: { (metadata, error ) in
                if error != nil{
                    return
                }
                let ref = Database.database().reference()
                let postRef = ref.child("Posts")
                let newPostId = postRef.childByAutoId().key
                let user = Auth.auth().currentUser
//                let newPostRef = postRef.child(newPostId!)
                let db = Firestore.firestore()
                
                storageRef.downloadURL(completion: {(url, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    }
//                    let downloadURL = url?.absoluteString
////                    let values: Dictionary<String, Any> = ["download_url": downloadURL]
               
                
                    db.collection("Posts").addDocument(data: [ "uid":  user!.uid, "postID": newPostId!, "imgURL": "gs://coursework-ios-730cb.appspot.com/Posts"+photoID, "caption": self.caption.text!]) { (error) in

                    if  error != nil{
                        let alert = UIAlertController(title: "Error", message: "Error in posting your post..", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                    let alert = UIAlertController(title: "Successful..", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                    self.caption.text = ""
                    self.photo.image = UIImage(named: "icons8-pictures-folder-100")
                    self.tabBarController?.selectedIndex = 0
                    }
        })
    })
            
 
    
}
   

}
}

extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
            photo.image = image
        }
        print(info)
        
        dismiss(animated: true, completion: nil)
}
}

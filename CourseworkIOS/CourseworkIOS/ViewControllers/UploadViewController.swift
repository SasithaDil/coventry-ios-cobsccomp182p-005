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
import ImagePicker


class UploadViewController: UIViewController {
    
    
    
    @IBOutlet weak var txtTime: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var btnTrash: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var photo: UIImageView!
    
    var selectedImage: UIImage!
    
    var ref: DatabaseReference!
    private var datePicker: UIDatePicker?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupElements()
        ImageUpload()
        setupDateTime()
        
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(UploadViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGuesture)
    }
    func setupElements(){
        Utilities.textFieldStyles(txtDate)
        Utilities.textFieldStyles(txtTime)
        Utilities.buttonStyles(btnShare)
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    func setupDateTime(){
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        
        datePicker?.addTarget(self, action: #selector(UploadViewController.dateChanged(datePicker:)), for: .valueChanged)
        txtDate.inputView = datePicker
    }
    @objc func dateChanged(datePicker: UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        txtDate.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
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
    
    @IBAction func cameraButton(_ sender: Any) {
    }
    @IBAction func Remove_post(_ sender: Any) {
        self.caption.text = ""
        self.photo.image = UIImage(named: "icons8-pictures-folder-100")
        self.txtDate.text = ""
        
    }
    
    @IBAction func Share(_ sender: Any) {
        if let postImg = self.selectedImage, let imageData = postImg.jpegData(compressionQuality: 0.1){
            let storageRef = Storage.storage().reference(forURL: "gs://coursework-ios-730cb.appspot.com").child("Posts").child("\(NSUUID().uuidString).jpg")
            storageRef.putData(imageData, metadata: nil, completion: { (metadata, error ) in
                if error != nil{
                    return
                }
                
                
                
                let ref = Database.database().reference()
                let postRef = ref.child("Posts")
                let newPostId = postRef.childByAutoId().key
                let user = Auth.auth().currentUser
                 ref.child("User").child(user!.uid).observe(.value) { (snapshot: DataSnapshot) in
                    
                    print(snapshot.value!)
                    
                    let dict = snapshot.value as? [String: Any]
                    let fname = dict!["FirstName"] as? String
                    let lname = dict!["LastName"] as? String
                    let profImage = dict!["ProfilePicURL"] as? String
                    
                    
                    let username =  fname!+" "+lname!
                    
                    
                    storageRef.downloadURL(completion: {(url, error) in
                        if error != nil {
                            print(error!.localizedDescription)
                            return
                        }
                        let pic = url?.absoluteString
                       
                        
                        let data = ["uid":  user!.uid,
                                    "postID": newPostId!,
                                    "imgURL": pic as Any,
                                    "caption": self.caption.text!,
                                    "username": username,
                                    "eventDate": self.txtDate.text!,
                                    "startingTime": self.txtTime.text!,
                                    "postDate": ServerValue.timestamp(),
                                    "profPic": profImage as Any] as [String : Any]
                        
                        ref.child("Posts").childByAutoId().setValue(data)
                        
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
                        self.txtDate.text = ""
                    })
                    
                }
                
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

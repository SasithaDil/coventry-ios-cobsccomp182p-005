//
//  PreviewViewController.swift
//  CourseworkIOS
//
//  Created by Sasitha Dilshan on 2/24/20.
//  Copyright © 2020 Sasitha Dilshan. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
 
    @IBOutlet weak var photo: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        photo.image = self.image

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func CancelButton(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        dismiss(animated: true, completion: nil)
    }
    
    
}

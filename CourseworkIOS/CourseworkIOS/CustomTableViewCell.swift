//
//  CustomTableViewCell.swift
//  CourseworkIOS
//
//  Created by Sasitha Dilshan on 2/24/20.
//  Copyright © 2020 Sasitha Dilshan. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    

//    @IBOutlet weak var captiontext: UILabel!
    @IBOutlet weak var captiontext: UILabel!
    @IBOutlet weak var imagePOST: UIImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profPic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profPic.layer.cornerRadius = profPic.frame.size.width/2
        profPic.clipsToBounds = true
        profPic.layer.borderColor = UIColor.blue.cgColor
        profPic.layer.borderWidth = 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}

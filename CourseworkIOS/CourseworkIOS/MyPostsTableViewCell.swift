//
//  MyPostsTableViewCell.swift
//  CourseworkIOS
//
//  Created by Sasitha Dilshan on 2/28/20.
//  Copyright © 2020 Sasitha Dilshan. All rights reserved.
//

import UIKit

class MyPostsTableViewCell: UITableViewCell {

    @IBOutlet weak var postCaption: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

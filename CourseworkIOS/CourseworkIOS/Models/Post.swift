//
//  Post.swift
//  CourseworkIOS
//
//  Created by Sasitha Dilshan on 2/19/20.
//  Copyright © 2020 Sasitha Dilshan. All rights reserved.
//

import Foundation
class Post{
    
    var caption : String
    var imgURL : String
    var user : String
    var userImageURL: String
    
    init(captionText: String, imagePath: String, userDetails: String, userPic: String) {
        caption = captionText
        imgURL = imagePath
        user = userDetails
        userImageURL = userPic
    }
}



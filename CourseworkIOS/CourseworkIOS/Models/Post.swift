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
    
    init(captionText: String, imagePath: String) {
        caption = captionText
        imgURL = imagePath
    }
}



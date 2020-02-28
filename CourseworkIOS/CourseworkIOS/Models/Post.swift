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
    var id: String
    var eventDate: String
    var eventTime: String
    var userID: String
//    var email: String
    
    init(captionText: String, imagePath: String, userDetails: String, userPic: String, postId: String, date: String, time: String, uid: String) {
        caption = captionText
        imgURL = imagePath
        user = userDetails
        userImageURL = userPic
        id = postId
        eventDate = date
        eventTime = time
        userID = uid
//        email = mail
//        , mail: String
    }
}



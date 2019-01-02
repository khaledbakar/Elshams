//
//  NewsFeedData.swift
//  Elshams
//
//  Created by mac on 12/16/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
class NewsFeedData {
    var userPostName : String?
    var videoPostUrl : String?
    var userPostImage :String?
    
    init(UserPostName:String,VideoPostUrl:String,UserPostImage:String) {
        self.userPostName = UserPostName
        self.videoPostUrl = VideoPostUrl
        self.userPostImage = UserPostImage
    }
}

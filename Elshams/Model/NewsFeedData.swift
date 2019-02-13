//
//  NewsFeedData.swift
//  Elshams
//
//  Created by mac on 12/16/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class NewsFeedData {
    var post_ID : String?
    var post_Author : String?
    var post_AutherPicture :String?
    var post_VideoURl :String?
    var post_Discription :String?
    var post_Type :String?

    var post_LikeCount :Int?
   // var post_Comments :[[String:Any]]?
     var post_Comments :[CommentsNewsFeed]?

    var post_Islike :Bool?
    var post_SharingLink :String?
    var post_Image :String?

    
init(Post_ID:String,Post_Author:String,Post_AutherPicture:String ,Post_VideoURl :String,Post_Discription :String,Post_LikeCount :Int,Post_Comments :[CommentsNewsFeed],Post_Islike :Bool,Post_SharingLink :String,Post_Image :String,Post_Type :String) { //Post_Comments :[[String:Any]]
    self.post_ID = Post_ID
    self.post_Author = Post_Author
    self.post_AutherPicture = Post_AutherPicture
    self.post_VideoURl = Post_VideoURl
    self.post_Discription = Post_Discription
    self.post_LikeCount = Post_LikeCount
    self.post_Comments = Post_Comments
    self.post_Islike = Post_Islike
    self.post_SharingLink = Post_SharingLink
    self.post_Image = Post_Image
    self.post_Type = Post_Type
    
    
    
    
    }
}

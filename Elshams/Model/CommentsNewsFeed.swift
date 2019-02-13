//
//  CommentsNewsFeed.swift
//  Elshams
//
//  Created by mac on 2/13/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
class CommentsNewsFeed {
    var author : String?
    var autherPic : String?
    var commentDiscription : String?
    
    init(Author:String,AutherPic:String,CommentDiscription:String) {
        self.author = Author
        self.autherPic = AutherPic
        self.commentDiscription = CommentDiscription
        
    }
}


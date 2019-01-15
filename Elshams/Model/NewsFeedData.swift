//
//  NewsFeedData.swift
//  Elshams
//
//  Created by mac on 12/16/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import UIKit
class NewsFeedData {
    var userPostName : String?
    var videoPostUrl : String?
    var userPostImage :String?
    var typePost :String?    
    var imagePost :UIImage?
    /*var cameraPost :String?
    var textPost :String?
    var locationPost :String?
    var attachPost :String? */



    init(UserPostName:String,VideoPostUrl:String,UserPostImage:String ,TypePost :String?,ImagePost :UIImage) { //,ImagePost :String,CameraPost :String,TextPost :String,LocationPost :String,AttachPost :String
        self.userPostName = UserPostName
        self.videoPostUrl = VideoPostUrl
        self.userPostImage = UserPostImage
        self.typePost = TypePost
        self.imagePost = ImagePost
       /* self.cameraPost = CameraPost
        self.textPost = TextPost
        self.locationPost = LocationPost
        self.attachPost = AttachPost */
    }
}

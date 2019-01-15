//
//  NewFeedsCell.swift
//  Elshams
//
//  Created by mac on 12/16/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import WebKit
class NewFeedsCell: UICollectionViewCell {
    
    @IBOutlet weak var userPostImage: UIImageView!
    @IBOutlet weak var videoContainer: WKWebView!
    @IBOutlet weak var userPostName: UILabel!
    @IBOutlet weak var photoPost: UIImageView!
    @IBOutlet weak var textPost: UILabel!
    var PostType : String = ""
    func setNewsFeedCeel(NewsfeedList:NewsFeedData)  { //,PostType:String
        PostType = (NewsfeedList.typePost)!
       userPostImage.image = UIImage(named: "\((NewsfeedList.userPostImage)!)")
        userPostImage.layer.cornerRadius = userPostImage.frame.width / 2
        userPostImage.clipsToBounds = true
        
        userPostName.text = (NewsfeedList.userPostName)!
        if PostType == "video" {
            photoPost.isHidden = true
            textPost.isHidden = true
            videoContainer.isHidden = false
        let videoUrl = NSURL(string: "\((NewsfeedList.videoPostUrl)!)")
        let requestObj = URLRequest(url: videoUrl as! URL)
        videoContainer.load(requestObj)
        }
        else if PostType == "photo"{
            photoPost.isHidden = false
            textPost.isHidden = true
            videoContainer.isHidden = true
            photoPost.image = NewsfeedList.imagePost
        
        }
        else if PostType == "text" {
            photoPost.isHidden = true
            textPost.isHidden = false
            videoContainer.isHidden = true
            textPost.text = NewsfeedList.videoPostUrl
        }
    }
    
    @IBAction func btnComment(_ sender: Any) {
        if  userPostName.textColor ==  UIColor.red {
            userPostName.textColor = UIColor.blue

        } else {
            userPostName.textColor = UIColor.red

        }
        
        
    }
    
    @IBAction func btnLike(_ sender: Any) {
        
    }
    
    @IBAction func btnShare(_ sender: Any) {
        
    }
    
}

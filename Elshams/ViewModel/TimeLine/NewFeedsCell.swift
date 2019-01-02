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
    
    func setNewsFeedCeel(NewsfeedList:NewsFeedData)  {
       userPostImage.image = UIImage(named: "\((NewsfeedList.userPostImage)!)")
        userPostImage.layer.cornerRadius = userPostImage.frame.width / 2
        userPostImage.clipsToBounds = true
        
        userPostName.text = (NewsfeedList.userPostName)!
        let videoUrl = NSURL(string: "\((NewsfeedList.videoPostUrl)!)")
        let requestObj = URLRequest(url: videoUrl as! URL)
        videoContainer.load(requestObj)
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

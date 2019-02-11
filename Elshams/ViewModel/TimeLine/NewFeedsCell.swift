//
//  NewFeedsCell.swift
//  Elshams
//
//  Created by mac on 12/16/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import AlamofireImage

class NewFeedsCell: UICollectionViewCell {
    @IBOutlet weak var userPostImage: UIImageView!
    @IBOutlet weak var videoContainer: WKWebView!
    @IBOutlet weak var userPostName: UILabel!
    @IBOutlet weak var photoPost: UIImageView!
    @IBOutlet weak var textPost: UILabel!
    var PostType : String = ""
    func setNewsFeedCeel(NewsfeedList:NewsFeedData)  {
        if NewsfeedList.post_AutherPicture != nil {
            imgUrl(imgUrl: (NewsfeedList.post_AutherPicture)!)
        }
        userPostImage.layer.cornerRadius = userPostImage.frame.width / 2
        userPostImage.clipsToBounds = true
        if NewsfeedList.post_Author != nil {
            userPostName.text = (NewsfeedList.post_Author)!

        }
        
        photoPost.isHidden = true
        textPost.isHidden = true
        
        
       videoContainer.isHidden = false
        if NewsfeedList.post_VideoURl != nil{
            let videoUrl = NSURL(string: "\((NewsfeedList.post_VideoURl)!)")
            let requestObj = URLRequest(url: videoUrl as! URL)
            videoContainer.load(requestObj)
        }
       
       
      /*
     if PostType == "video" {
     photoPost.isHidden = true
     textPost.isHidden = true
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
        } */
    }
    
    func imgUrl(imgUrl:String)  {
        if let imagUrlAl = imgUrl as? String {
            Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                print(response)
                switch response.result {
                case .success(let value):
                if let image = response.result.value {
                    DispatchQueue.main.async{
                        self.userPostImage.image = image
                    }
                }
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
    
    @IBAction func btnComment(_ sender: Any) {
       /* if  userPostName.textColor ==  UIColor.red {
            userPostName.textColor = UIColor.blue

        } else {
            userPostName.textColor = UIColor.red

        }
        */
        
    }
    
    @IBAction func btnLike(_ sender: Any) {
        
    }
    
    @IBAction func btnShare(_ sender: Any) {
        
    }
    
}

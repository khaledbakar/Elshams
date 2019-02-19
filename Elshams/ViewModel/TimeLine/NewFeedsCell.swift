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
import SwiftyJSON

class NewFeedsCell: UICollectionViewCell {
    @IBOutlet weak var userPostImage: UIImageView!
    @IBOutlet weak var videoContainer: WKWebView!
    @IBOutlet weak var userPostName: UILabel!
    @IBOutlet weak var photoPost: UIImageView!
    @IBOutlet weak var textPost: UILabel!
     @IBOutlet weak var likeImage: UIImageView!

    @IBOutlet weak var likeCounterLabel: UILabel!
    var postType : String = ""
    var postId = ""
    var postLikeCounter = ""

    var postIsLike = false

    func setNewsFeedCeel(NewsfeedList:NewsFeedData)  {
        postId = NewsfeedList.post_ID!
        userPostImage.layer.cornerRadius = userPostImage.frame.width / 2
        userPostImage.clipsToBounds = true
        if NewsfeedList.post_AutherPicture != nil {
            Helper.loadImagesKingFisher(imgUrl: (NewsfeedList.post_AutherPicture)!, ImgView: userPostImage)
        }
        if NewsfeedList.post_Author == nil || NewsfeedList.post_Author == "" {
            userPostName.text = "CIT"

        } else {
            userPostName.text = (NewsfeedList.post_Author)!

        }
        postIsLike = NewsfeedList.post_Islike!
        let likeCounter = NewsfeedList.post_LikeCount
        if likeCounter == 0 || likeCounter == nil {
            if NewsfeedList.post_Islike == true {
                likeCounterLabel.isHidden = false
             
                likeImage.image = UIImage(named: "liked")

                likeCounterLabel.text = "You like this"
            } else {
                likeCounterLabel.textColor = UIColor.black
                likeImage.image = UIImage(named: "like")

                likeCounterLabel.isHidden = true
            }
        } else {
            postLikeCounter = "\(likeCounter!)"
            if NewsfeedList.post_Islike == true {
                likeCounterLabel.isHidden = false
                likeImage.image = UIImage(named: "liked")

                likeCounterLabel.textColor = UIColor.blue
                likeCounterLabel.text = "You,and \(likeCounter!) like this"
            } else {
                likeCounterLabel.textColor = UIColor.black
                likeImage.image = UIImage(named: "like")

                likeCounterLabel.isHidden = false
                  likeCounterLabel.text = "\(likeCounter!) likes this"
            }
        }
 
        photoPost.isHidden = true
        textPost.isHidden = true
        postType = NewsfeedList.post_Type!
     if postType == "video" {
     photoPost.isHidden = true
     textPost.isHidden = true
        
        if NewsfeedList.post_VideoURl != nil{
            let videoUrl = NSURL(string: "\((NewsfeedList.post_VideoURl)!)")
            let requestObj = URLRequest(url: videoUrl as! URL)
            videoContainer.load(requestObj)
            videoContainer.isHidden = false
        }
          }
     else if postType == "text"{
            photoPost.isHidden = false
            textPost.isHidden = true
            videoContainer.isHidden = true
        Helper.loadImagesKingFisher(imgUrl: NewsfeedList.post_Image!, ImgView: photoPost)
        
        }
        else if postType == "video_text" {
        Helper.loadImagesKingFisher(imgUrl: NewsfeedList.post_Image!, ImgView: photoPost)

        textPost.text = NewsfeedList.post_Discription!

            photoPost.isHidden = false
            textPost.isHidden = false
            videoContainer.isHidden = true
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
    func getId(url:String) {
      //  let  pattern = @"(?:https?:\/\/)?(?:www\.)?(?:(?:(?:youtube.com\/watch\?[^?]*v=|youtu.be\/)([\w\-]+))(?:[^\s?]+)?)"

    }
    
    
    @IBAction func btnLike(_ sender: Any) {
        if let  apiToken  = Helper.getApiToken() {
            let postLikeID : Parameters = ["PostID" : "\((postId))"]
            if postIsLike == true {
                postIsLike = false
                OpenSessionVC.likeFlag = "faveMethod"
               // likeImage.backgroundColor = UIColor.clear
                likeImage.image = UIImage(named: "like")

                likeCounterLabel.isHidden = false
                likeCounterLabel.text = "\(postLikeCounter) "
                likeCounterLabel.textColor = UIColor.black

                Service.postServiceWithAuth(url: URLs.addUnLikeTopost, parameters: postLikeID) {
                    (response) in
                    print(response)
                    let result = JSON(response)
                    OpenSessionVC.likeFlag = ""
                }
            }
            else {
                postIsLike = true
                OpenSessionVC.likeFlag = "faveMethod"
              //  likeImage.backgroundColor = UIColor.blue
                likeImage.image = UIImage(named: "liked")
                likeCounterLabel.isHidden = false
                likeCounterLabel.text = "You,and \(postLikeCounter) like this"
                likeCounterLabel.textColor = UIColor.blue
                Service.postServiceWithAuth(url: URLs.addLikeTopost, parameters: postLikeID) {
                    (response) in
                    
                    print(response)
                    let result = JSON(response)
                    OpenSessionVC.likeFlag = ""
                    
                }
                
            }
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("ErrorLikeSignIn"), object: nil)
            //  dismiss(animated: true, completion: nil
        }
    }

    
    @IBAction func btnShare(_ sender: Any) {
       
}
}

//
//  postsDetails.swift
//  Elshams
//
//  Created by mac on 2/17/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import WebKit

class postsDetails: UIViewController {

    var singlePostsItem : NewsFeedData?

    @IBOutlet weak var postsTimeLineContainer: UIView!
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var videoContainerWV: WKWebView!
    @IBOutlet weak var authorPic: UIImageView!
    @IBOutlet weak var authorPost: UILabel!
    @IBOutlet weak var likeUnlikeImg: UIImageView!
    @IBOutlet weak var likeCounter: UILabel!
    @IBOutlet weak var postDescribtion: UITextView!
    var postLikeCounter = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPostData()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    func imgUrl(imgUrl:String,imageView:UIImageView)  {
        if imgUrl == "" || imgUrl == nil {
            return
        } else {
            if let imagUrlAl = imgUrl as? String {
                Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                    print(response)
                    switch response.result {
                    case .success(let value):
                        if let image = response.result.value {
                            DispatchQueue.main.async{
                                imageView.image = image
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                })
            }
        }
    }
    
    func loadPostData()  {
        self.navigationItem.title = "Post"
        postsTimeLineContainer.isHidden = false
        if singlePostsItem?.post_Type == "text" || singlePostsItem?.post_Type == "video_text" {
            videoContainerWV.isHidden = true
            imgUrl(imgUrl: (singlePostsItem?.post_Image)!, imageView: imagePost)
            
        }
        else if singlePostsItem?.post_Type == "video"  {
            videoContainerWV.isHidden = false
            if singlePostsItem?.post_VideoURl != nil {
                let videoUrl = NSURL(string: "\((singlePostsItem?.post_VideoURl)!)")
                let requestObj = URLRequest(url: videoUrl as! URL)
                videoContainerWV.load(requestObj)
            }
        }
        authorPic.layer.cornerRadius = authorPic.frame.width / 2
        authorPic.clipsToBounds = true
        if singlePostsItem?.post_AutherPicture == "" || singlePostsItem?.post_AutherPicture == nil {
            authorPic.image = UIImage(named: "home-logo")        

        }else {
        imgUrl(imgUrl: (singlePostsItem?.post_AutherPicture)!, imageView: authorPic)
        }
        if singlePostsItem?.post_Author == "" || singlePostsItem?.post_Author == nil {
            authorPost.text = "CIT"
        } else {
            authorPost.text = singlePostsItem?.post_Author

        }
        let postDesc = singlePostsItem?.post_Discription
        postDescribtion.text = postDesc?.htmlToString
      
        
        likeUnlikeImg.layer.cornerRadius = likeUnlikeImg.frame.width / 2
        likeUnlikeImg.clipsToBounds = true
        
        let likeCounterInt = singlePostsItem?.post_LikeCount
        if likeCounterInt == 0 || likeCounterInt == nil {
            if singlePostsItem?.post_Islike == true {
                likeCounter.isHidden = false
                //   likeImage.backgroundColor = UIColor.blue
                //  likeImage.backgroundColor = UIColor.blue
                likeUnlikeImg.image = UIImage(named: "liked")
                likeCounter.text = "" //You like this
            } else {
                //  likeImage.backgroundColor = UIColor.clear
                likeCounter.textColor = UIColor.black
                likeUnlikeImg.image = UIImage(named: "like")
                
                //  likeCounterLabel.text = "You,and \((NewsfeedList.post_LikeCount)!) likes"
                likeCounter.isHidden = true
            }
        } else {
            postLikeCounter = "\(likeCounter!)"
            if singlePostsItem?.post_Islike == true {
                likeCounter.isHidden = false
                // likeImage.backgroundColor = UIColor.blue
                likeUnlikeImg.image = UIImage(named: "liked")
                
                likeCounter.textColor = UIColor.blue
                likeCounter.text = "\(likeCounterInt!)"
            } else {
                // likeImage.backgroundColor = UIColor.clear
                likeCounter.textColor = UIColor.black
                likeUnlikeImg.image = UIImage(named: "like")
                
                likeCounter.isHidden = false
                likeCounter.text = "\(likeCounterInt!)"
                // likeCounterLabel.isHidden = true
            }
        }
        
        
        
        /*   if singlePostsItem?.post_Islike == {
         
         } else {
         
         } */
        
        
        
    }

    

}

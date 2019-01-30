//
//  TimeLineHomeVC.swift
//  Elshams
//
//  Created by mac on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class TimeLineHomeVC: BaseViewController , UICollectionViewDataSource , UICollectionViewDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate {
    @IBOutlet weak var scrollTimeLineView: UIScrollView!
    @IBOutlet weak var viewPostContols: UIView!
    
    @IBOutlet weak var viewTimeLineView: UIView!
    @IBOutlet weak var homeLogo: UIImageView!
    
    @IBOutlet weak var homeNameAbout: UIImageView!
    
    @IBOutlet weak var homeAbout: UITextView!
    var newsFeedList = Array<NewsFeedData>()
    
    @IBOutlet weak var timeLineCollView: UICollectionView!
    @IBOutlet weak var sponserImg1: UIImageView!
    @IBOutlet weak var sponserImg2: UIImageView!
    @IBOutlet weak var sponserImg3: UIImageView!
    @IBOutlet weak var sponserImg4: UIImageView!

    @IBOutlet weak var sponserName1: UILabel!
    @IBOutlet weak var sponserName2: UILabel!
    @IBOutlet weak var sponserName3: UILabel!
    @IBOutlet weak var sponserName4: UILabel!

    @IBOutlet weak var speakerImg1: UIImageView!
    @IBOutlet weak var speakerImg2: UIImageView!
    @IBOutlet weak var speakerImg3: UIImageView!
    @IBOutlet weak var speakerImg4: UIImageView!

    @IBOutlet weak var speakerName1: UILabel!
    @IBOutlet weak var speakerName2: UILabel!
    @IBOutlet weak var speakerName3: UILabel!
    @IBOutlet weak var speakerName4: UILabel!

    @IBOutlet weak var postProfileImage: UIImageView!
    @IBOutlet weak var postText: UITextField!
    var imagePicker: UIImagePickerController!
    static  var imagePost : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()

        viewPostContols.isHidden = true
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        postText.delegate = self
        loadPostsData()
        
        
    }

    func loadPostsData()  {
        Service.getServiceWithAuth(url: (URLs.getAllPosts)) {
            (response) in
            print("this is Posts ")
            print(response)
            let json = JSON(response)
            let result = json["AllPosts"]
            var iDNotNull = true
            var index = 0
            while iDNotNull {
                let post_ID = result[index]["ID"].string
                if post_ID == nil || post_ID?.trimmed == "" || post_ID == "null" || post_ID == "nil" {
                    iDNotNull = false
                    break
                }
                let post_Author = result[index]["author"].string
                let post_AutherPic = result[index]["autherPic"].string
                let post_VedioURl = result[index]["vedioURl"].string
                let post_Discription = result[index]["postDiscription"].string
                let post_LikeCount = result[index]["about"].int
                let post_Comments = result[index]["Comments"].array
                let post_Islike = result[index]["Islike"].bool
                let post_SharingLink = result[index]["sharingLink"].string
                let post_Image = result[index]["image"].string
               
             /*   var iDNotNullComment = true
                var indexComm = 0
                while iDNotNullComment {
                    let post_CommentDiscription = post_Comments?[indexComm]["commentDiscription"].string

                    if post_CommentDiscription == nil || post_CommentDiscription?.trimmed == "" || post_CommentDiscription == "null" || post_CommentDiscription == "nil" {
                        iDNotNull = false
                        break
                    }
                    let post_author = post_Comments?[indexComm]["author"].string
                    let post_autherPic = post_Comments?[indexComm]["autherPic"].string
                    indexComm = indexComm + 1
                }
                */
                
               
                self.newsFeedList.append(NewsFeedData(Post_ID: post_ID ?? "", Post_Author: post_Author ?? "", Post_AutherPicture: post_AutherPic ?? "", Post_VideoURl: post_VedioURl ?? "" , Post_Discription: post_Discription ?? "", Post_LikeCount: post_LikeCount ?? 0, Post_Comments: post_Comments ?? [result], Post_Islike: post_Islike ?? false, Post_SharingLink: post_SharingLink ?? "", Post_Image: post_Image ?? ""))
                index = index + 1
                self.timeLineCollView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsFeedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsfeedcell", for: indexPath) as! NewFeedsCell
        cell.setNewsFeedCeel(NewsfeedList: newsFeedList[indexPath.row])
        return cell
    }
    
    
    @IBAction func moreSponsers(_ sender: Any) {
        MenuViewController.sponserEventOrMenu = true
        performSegue(withIdentifier: "sponserspage", sender: nil)
    }
    @IBAction func btnAgenda(_ sender: Any) {
         performSegue(withIdentifier: "agendabarbtn", sender: nil)
    }
    
    @IBAction func moreSpeaker(_ sender: Any) {
        MenuViewController.speakerEventOrMenu = true
        Service.getService(url: "http://66.226.74.85:4002/api/Event/getNetwork", callback: { (response) in
            print("this is json")
            print(response)
        })
 
        performSegue(withIdentifier: "speakerpage", sender: nil)
    }
    
    @IBAction func btnPost(_ sender: Any) {
     //  newsFeedList.append(NewsFeedData(UserPostName: "Khaled", VideoPostUrl: postText.text! , UserPostImage: "avatar", TypePost: "text", ImagePost: UIImage(named: "avatar")!))
        timeLineCollView.reloadData()
        postText.text = ""

    }
    
    @IBAction func btnAttachPost(_ sender: Any) {
        print("attachment")
    }
    
    @IBAction func btnCameraPost(_ sender: Any) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
           // profileImage.image = image
           TimeLineHomeVC.imagePost  = image
            postText.text = "Image Has Uploaded Post it !"
         //   newsFeedList.append(NewsFeedData(UserPostName: "Khaled", VideoPostUrl: "", UserPostImage: "avatar", TypePost: "photo", ImagePost: image))
            timeLineCollView.reloadData()
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnGalleryPost(_ sender: Any) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker,animated: true , completion: nil)

        print("btnGalleryPost")
    }
    
    @IBAction func btnLocationPost(_ sender: Any) {
        print("btnLocationPost")

    }
    
    @IBAction func appointmentPage(_ sender: Any) {
        print("appointmentPage")

      //  performSegue(withIdentifier: "appointment", sender: nil)
    }
    
    
}

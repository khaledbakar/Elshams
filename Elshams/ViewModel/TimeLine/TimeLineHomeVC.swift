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
    var speakerList = Array<Speakers>()
    var sponserList = Array<Sponsers>()
    static var failMessage = ""

    
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
        //sponser round
        loadAboutData()
        sponserImg1.layer.cornerRadius = sponserImg1.frame.width / 2
        sponserImg1.clipsToBounds = true
       
        sponserImg2.layer.cornerRadius = sponserImg2.frame.width / 2
        sponserImg2.clipsToBounds = true
       
        sponserImg3.layer.cornerRadius = sponserImg3.frame.width / 2
        sponserImg3.clipsToBounds = true
      
        sponserImg4.layer.cornerRadius = sponserImg4.frame.width / 2
        sponserImg4.clipsToBounds = true
        
        // speaker round
        speakerImg1.layer.cornerRadius = speakerImg1.frame.width / 2
        speakerImg1.clipsToBounds = true
        
        speakerImg2.layer.cornerRadius = speakerImg2.frame.width / 2
        speakerImg2.clipsToBounds = true
        
        speakerImg3.layer.cornerRadius = speakerImg3.frame.width / 2
        speakerImg3.clipsToBounds = true
        
        speakerImg4.layer.cornerRadius = speakerImg4.frame.width / 2
        speakerImg4.clipsToBounds = true
        
        viewPostContols.isHidden = true
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        postText.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(errorAlert), name: NSNotification.Name("ErrorConnections"), object: nil)

        loadPostsData()
        loadAllSpeakerData()
        loadAllSponserData()
        
     /*   if TimeLineHomeVC.failMessage ==  "fail"
      {
        let alert = UIAlertController(title: "Error", message: "No internet connection please turn on it", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        } */
  
    }
    
    @objc func errorAlert(){
        let alert = UIAlertController(title: "Error!", message: Service.errorConnection, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        //  startupTableView.isHidden = true
    //    activeLoader.isHidden = true
        //  activeLoader.stopAnimating()
        //reload after
        //
    }

    func loadAllSpeakerData()  {
        Service.getService(url: URLs.getAllSpeaker) {
            (response) in
            print(response)
         //   if response != nil {
            let json = JSON(response)
            let result = json["AllSpeaker"]
            if !(result.isEmpty){
            var iDNotNull = true
            var index = 0
            while index < 4 {
                let speaker_ID = result[index]["ID"].string
                let speaker_Name = result[index]["name"].string
                let speaker_JobTitle = result[index]["jobTitle"].string
                let speaker_CompanyName = result[index]["companyName"].string
                let speaker_ImageUrl = result[index]["imageUrl"].string
                let speaker_About = result[index]["about"].string
                let speaker_ContectInforamtion = result[index]["ContectInforamtion"].dictionaryObject
                let speaker_Email = result[index]["ContectInforamtion"]["Email"].string
                let speaker_Linkedin = result[index]["ContectInforamtion"]["linkedin"].string
                let speaker_Phone = result[index]["ContectInforamtion"]["phone"].string
                let contect = ["Email": "","linkedin": "","phone": ""]
                if speaker_ID == nil || speaker_ID?.trimmed == "" || speaker_ID == "null" || speaker_ID == "nil" {
                    iDNotNull = false
                    break
                }
                self.speakerList.append(Speakers(SpeakerName: speaker_Name ?? "name", JobTitle: speaker_JobTitle ?? "JOB", CompanyName: speaker_CompanyName ?? "Company", SpImageUrl: speaker_ImageUrl ?? "Image", Speaker_id: speaker_ID ?? "ID", ContectInforamtion: speaker_ContectInforamtion ?? contect, About: speaker_About ?? "About"))
                index = index + 1
               /* self.speakerTableView.reloadData()
                self.speakerCollectionView.reloadData()
                self.activeLoader.isHidden = true
                self.activeLoader.stopAnimating()
                self.speakerTableView.isHidden = false */
            }
                if !(self.speakerList.isEmpty){
            self.speakerName1.text = self.speakerList[0].name
            self.speakerName2.text = self.speakerList[1].name
            self.speakerName3.text = self.speakerList[2].name
            self.speakerName4.text = self.speakerList[3].name
              //  if self.speakerList[0].speakerImageUrl != nil{
            self.imgUrl(imgUrl: self.speakerList[0].speakerImageUrl!, ImageViewSet: self.speakerImg1)
             //   }
            self.imgUrl(imgUrl: self.speakerList[1].speakerImageUrl!, ImageViewSet: self.speakerImg2)
            self.imgUrl(imgUrl: self.speakerList[2].speakerImageUrl!, ImageViewSet: self.speakerImg3)
            self.imgUrl(imgUrl: self.speakerList[3].speakerImageUrl!, ImageViewSet: self.speakerImg4)
                }
           //MenuViewController.imgUserTestUrl = self.speakerList[0].speakerImageUrl!  //test menu user image
            } else {
                // if no data in speaker what doing ??
            }
        }
    }
    
    func loadAllSponserData()  {
        Service.getService(url: URLs.getAllSponsors) {
            (response) in
            print(response)
       //     if response != nil {
            let json = JSON(response)

            let result = json["AllSponsers"]
        if !(result.isEmpty){
            var iDNotNull = true
            var index = 0
            while index < 4 {
                let sponser_ID = result[index]["ID"].string
                let sponser_Name = result[index]["name"].string
                let sponser_Address = result[index]["address"].string
                let sponser_ImageUrl = result[index]["imageUrl"].string
                let sponser_About = result[index]["about"].string
                let sponser_ContectInforamtion = result[index]["ContectInforamtion"].dictionaryObject
                
                let sponser_Email = result[index]["ContectInforamtion"]["Email"].string
                let sponser_Linkedin = result[index]["ContectInforamtion"]["linkedin"].string
                let sponser_Phone = result[index]["ContectInforamtion"]["phone"].string
                
                let sponser_Sponsertype = result[index]["Sponsertype"].dictionaryObject
                let sponser_Sponsertype_ID = result[index]["Sponsertype"]["id"].string
                let sponser_Sponsertype_name = result[index]["Sponsertype"]["name"].string
                let sponser_Sponsertype_icon = result[index]["Sponsertype"]["icon"].string
                let sponser_Sponsertype_Color = result[index]["Sponsertype"]["color"].string
                
                let contectOptionNil = ["Email": "","linkedin": "","phone": ""]
                let sponserTypeOptionNil = ["id": "Media Partner","name": "Media Partner","icon": "","color": "#053a8e"]
                
                if sponser_ID == nil || sponser_ID?.trimmed == "" || sponser_ID == "null" || sponser_ID == "nil" {
                    iDNotNull = false
                    break
                }
                self.sponserList.append(Sponsers(SponserName: sponser_Name ?? "name", SponserAddress: sponser_Address ?? "address", SponserImageURL: sponser_ImageUrl ?? "Image", SponserAbout: sponser_About ?? "ABout", SponserID: sponser_ID ?? "ID", ContectInforamtion: sponser_ContectInforamtion ?? contectOptionNil, Sponsertype: sponser_Sponsertype ?? sponserTypeOptionNil))
                index = index + 1
               
             
            }
            //suggestion make it scrollview
                if !(self.sponserList.isEmpty) {   
            self.sponserName1.text = self.sponserList[0].sponserName
            self.sponserName2.text = self.sponserList[1].sponserName
            self.sponserName3.text = self.sponserList[2].sponserName
            self.sponserName4.text = self.sponserList[3].sponserName
            self.imgUrl(imgUrl: self.sponserList[0].sponserImageUrl!, ImageViewSet: self.sponserImg1)
            self.imgUrl(imgUrl: self.sponserList[1].sponserImageUrl!, ImageViewSet: self.sponserImg2)
            self.imgUrl(imgUrl: self.sponserList[2].sponserImageUrl!, ImageViewSet: self.sponserImg3)
            self.imgUrl(imgUrl: self.sponserList[3].sponserImageUrl!, ImageViewSet: self.sponserImg4)
        }
        } else {
            // if no data in sponser what doing ??

            }
            
            }
    }
    
    func loadAboutData()  {
        
        Service.getService(url: (URLs.getAbout)) {
            (response) in
            print("this is About ")
            print(response)

            let json = JSON(response)
            
            let result = json["AboutInfo"].string
            if !(result!.isEmpty){
                self.homeAbout.text = result?.htmlToString
            } else {
                // if no data in posts what doing ??
                
            }
        }
    }
    
    func loadPostsData()  {
      
        Service.getService(url: (URLs.getAllPosts)) {
            (response) in
            print("this is Posts ")
            print(response)
          //  if response != nil {

            let json = JSON(response)

            let result = json["AllPosts"]
            if !(result.isEmpty){
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
           // }
            }
            } else {
                // if no data in posts what doing ??

            }
    }
    }
    
    func imgUrl(imgUrl:String,ImageViewSet:UIImageView)  {
        
        if let imagUrlAl = imgUrl as? String {
            Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                print(response)
                if response != nil {
                    switch response.result {
                    case .success(let value):
                if let image = response.result.value {
                    DispatchQueue.main.async{
                        ImageViewSet.image = image
                    }
                    }
                    case .failure(let error):
                        print(error)
                    }
                }
            })
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
      /*  Service.getService(url: "http://66.226.74.85:4002/api/Event/getNetwork", callback: { (response) in
            print("this is json")
            print(response)
        })
        */
 
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

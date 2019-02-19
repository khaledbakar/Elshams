//
//  TimeLineHomeVC.swift
//  Elshams
//
//  Created by mac on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire
//import AlamofireImage
import SwiftyJSON

class TimeLineHomeVC: BaseViewController , UICollectionViewDataSource , UICollectionViewDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate , UIScrollViewDelegate{
    
    @IBOutlet weak var scrollSponserContainer: UIScrollView!
    
    @IBOutlet weak var scrollSpeakerContainer: UIScrollView!
    @IBOutlet weak var scrollTimeLineView: UIScrollView!
    @IBOutlet weak var viewPostContols: UIView!
    
    @IBOutlet weak var viewTimeLineView: UIView!
    @IBOutlet weak var homeLogo: UIImageView!
    
    @IBOutlet weak var showPostTypeContainer: UIView!
    @IBOutlet weak var homeNameAbout: UIImageView!
    
    @IBOutlet weak var homeAbout: UITextView!
    var newsFeedList = Array<NewsFeedData>()
    var masterDataNewsFeedList = Array<NewsFeedData>()

    var videoNewsFeedList = Array<NewsFeedData>()
    var textNewsFeedList = Array<NewsFeedData>()
    var videoTextNewsFeedList = Array<NewsFeedData>()

    var commentNewsFeedList = Array<CommentsNewsFeed>()

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
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var frameLabel = CGRect(x: 0, y: 0, width: 0, height: 0)
    var frameSpeaker = CGRect(x: 0, y: 0, width: 0, height: 0)
    var frameSpeakerLabel = CGRect(x: 0, y: 0, width: 0, height: 0)

    var scrolImageUrl : String?
    var scrolSpeakerImageUrl : String?


    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        loadAboutData()

        hideShowFixedSponser(Order: true)
        hideShowFixedSpeaker(Order: true)

        viewPostContols.isHidden = true
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        postText.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(errorAlert), name: NSNotification.Name("ErrorConnections"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorAlert), name: NSNotification.Name("ErrorLikeSignIn"), object: nil)

        loadPostsData()
        loadAllSpeakerData()
        loadAllSponserData()

    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    //MARK:- Hide & Show Fixed Sponser/Speaker
    func hideShowFixedSponser(Order:Bool) {
        //sponser round
        sponserImg1.layer.cornerRadius = sponserImg1.frame.width / 2
        sponserImg1.clipsToBounds = true
        
        sponserImg2.layer.cornerRadius = sponserImg2.frame.width / 2
        sponserImg2.clipsToBounds = true
        
        sponserImg3.layer.cornerRadius = sponserImg3.frame.width / 2
        sponserImg3.clipsToBounds = true
        
        sponserImg4.layer.cornerRadius = sponserImg4.frame.width / 2
        sponserImg4.clipsToBounds = true
        
        sponserName1.isHidden = Order
        sponserName2.isHidden = Order
        sponserName3.isHidden = Order
        sponserName4.isHidden = Order
        sponserImg1.isHidden = Order
        sponserImg2.isHidden = Order
        sponserImg3.isHidden = Order
        sponserImg4.isHidden = Order
    }
    func hideShowFixedSpeaker(Order:Bool) {
        // speaker round
        speakerImg1.layer.cornerRadius = speakerImg1.frame.width / 2
        speakerImg1.clipsToBounds = true
        
        speakerImg2.layer.cornerRadius = speakerImg2.frame.width / 2
        speakerImg2.clipsToBounds = true
        
        speakerImg3.layer.cornerRadius = speakerImg3.frame.width / 2
        speakerImg3.clipsToBounds = true
        
        speakerImg4.layer.cornerRadius = speakerImg4.frame.width / 2
        speakerImg4.clipsToBounds = true
        
        speakerName1.isHidden = Order
        speakerName2.isHidden = Order
        speakerName3.isHidden = Order
        speakerName4.isHidden = Order
        speakerImg1.isHidden = Order
        speakerImg2.isHidden = Order
        speakerImg3.isHidden = Order
        speakerImg4.isHidden = Order
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var pageNumber = scrollSponserContainer.contentOffset.x / scrollSponserContainer.frame.size.width
        var pageNumberSpeaker = scrollSpeakerContainer.contentOffset.x / scrollSpeakerContainer.frame.size.width

       // newsControl.currentPage = Int(pageNumber)
    }
    
    //MARK:- ScrollSponser
    func loadSponserScroll()  {
       // scrollSponserContainer.contentSize = CGSize(width: (scrollSponserContainer.frame.size.width * CGFloat(sponserList .count)) , height: scrollSponserContainer.frame.size.height)
        hideShowFixedSponser(Order: true)
        scrollSponserContainer.contentSize = CGSize(width: (80 * CGFloat(sponserList .count)) , height: scrollSponserContainer.frame.size.height)

        scrollSponserContainer.delegate = self
       // newsControl.numberOfPages = topNewsList.count
        for index in 0..<sponserList.count {
      /*      if index == 0 {
                frame.origin.x = 20
                frameLabel.origin.x = 20

            }
        /*    else if index == 1 {
                frame.origin.x = 90
                frameLabel.origin.x = 86

            } */
            else { */
                frame.origin.x = 80 * CGFloat(index)
            //    frame.origin.x = (frame.origin.x + frame.width + 10) * CGFloat(index)

                frameLabel.origin.x = 80 * CGFloat(index)

       //     }
            frame.origin.y = 10
            frameLabel.origin.y = 70
          //  frame.origin.x = scrollSponserContainer.frame.size.width * CGFloat(index)

          //  frame.size = CGSize(width: scrollSponserContainer.frame.size.width , height: 233.0)
          //  frame.size = CGSize(width: sponserImg1.frame.width , height: sponserImg1.frame.height)
            frame.size = CGSize(width: 50 , height: 50)
            frameLabel.size = CGSize(width: 80 , height: 20)

            let titleLbl = UILabel(frame: frameLabel)
            titleLbl.text = sponserList[index].sponserName
            titleLbl.numberOfLines = 1
            titleLbl.textColor = UIColor.black
            titleLbl.font = titleLbl.font.withSize(12.0)
          //  titleLbl.textAlignment = nsa
            titleLbl.tag = index + 1
            print(titleLbl.tag)
            
            let sponserDetailLbl = UITapGestureRecognizer(target: self, action: #selector(TimeLineHomeVC.sponserDetailLabel))
            titleLbl.isUserInteractionEnabled = true
            titleLbl.addGestureRecognizer(sponserDetailLbl)
            
            let imgView = UIImageView(frame: frame)
            scrolImageUrl = sponserList[index].sponserImageUrl
            if scrolImageUrl != nil {
                Helper.loadImagesKingFisher(imgUrl: scrolImageUrl!, ImgView: imgView)
            }
            imgView.layer.cornerRadius = imgView.frame.width / 2
            imgView.clipsToBounds = true
            imgView.contentMode = .scaleAspectFit
       //     imgView.widthAnchor.constraint(equalToConstant: 80)
           // imgView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width)
        //    imgView.topAnchor.constraint(equalTo:  scrollSponserContainer.topAnchor, constant: 15)
          //  imgView.rightAnchor.constraint(equalTo:  imgView.leftAnchor, constant: 25)

     //       imgView.bottomAnchor.constraint(equalTo:  titleLbl.bottomAnchor, constant: 0)
            imgView.tag = index + 1
            let sponserDetailImg = UITapGestureRecognizer(target: self, action: #selector(TimeLineHomeVC.sponserDetailImg))
            imgView.isUserInteractionEnabled = true
            imgView.addGestureRecognizer(sponserDetailImg)
         /*
            let titleView = UIView(frame: frame)
            titleView.backgroundColor = UIColor.black
            titleView.backgroundColor = UIColor(white: 0, alpha: 0.5)
 
            let topNewsImage = UITapGestureRecognizer(target: self, action: #selector(NewsVC.topNewsImageFunc))
            titleView.isUserInteractionEnabled = true
            titleView.addGestureRecognizer(topNewsImage)
            titleView.tag = index + 1
            print(titleView.tag)
            
            titleView.addSubview(titleLbl)  */
            
            scrollSponserContainer.addSubview(imgView)
            scrollSponserContainer.addSubview(titleLbl)
        }
    }
    @objc func sponserDetailLabel(sender:UIGestureRecognizer) {
        guard let tag = (sender.view as? UILabel)?.tag else {
           // return
         //   let tag = (sender.view as? UIImageView)?.tag
            return
        }
        
        performSegue(withIdentifier: "sponsertimelinedetail", sender: sponserList[tag - 1])
        
    }
    
    @objc func sponserDetailImg(sender:UIGestureRecognizer) {
        guard let tag = (sender.view as? UIImageView)?.tag else {
            // return
            //   let tag = (sender.view as? UIImageView)?.tag
            return
        }
        
        performSegue(withIdentifier: "sponsertimelinedetail", sender: sponserList[tag - 1])
        
    }
  
    //MARK:- Scroll Speaker
    func loadSpeakerScroll()  {
        hideShowFixedSpeaker(Order: true)
        scrollSpeakerContainer.contentSize = CGSize(width: (80 * CGFloat(speakerList.count)) , height: scrollSpeakerContainer.frame.size.height)
        scrollSpeakerContainer.delegate = self
        for index in 0..<speakerList.count {
    
            frameSpeaker.origin.x = 80 * CGFloat(index)
            frameSpeakerLabel.origin.x = 80 * CGFloat(index)
        
            frameSpeaker.origin.y = 10
            frameSpeakerLabel.origin.y = 70
         
            frameSpeaker.size = CGSize(width: 50 , height: 50)
            frameSpeakerLabel.size = CGSize(width: 80 , height: 20)
            
            let titleLbl = UILabel(frame: frameSpeakerLabel)
            titleLbl.text = speakerList[index].name
            titleLbl.numberOfLines = 1
            titleLbl.textColor = UIColor.black
            titleLbl.font = titleLbl.font.withSize(12.0)
            titleLbl.tag = index + 1
            print(titleLbl.tag)
            
            let speakerDetailLbl = UITapGestureRecognizer(target: self, action: #selector(TimeLineHomeVC.speakerDetailLabel))
            titleLbl.isUserInteractionEnabled = true
            titleLbl.addGestureRecognizer(speakerDetailLbl)
            
            let imgView = UIImageView(frame: frameSpeaker)
            scrolImageUrl = speakerList[index].speakerImageUrl
            if scrolImageUrl != nil {
                Helper.loadImagesKingFisher(imgUrl: scrolImageUrl!, ImgView: imgView)
            }
            imgView.layer.cornerRadius = imgView.frame.width / 2
            imgView.clipsToBounds = true
            imgView.contentMode = .scaleAspectFit

            imgView.tag = index + 1
            let speakerDetailImg = UITapGestureRecognizer(target: self, action: #selector(TimeLineHomeVC.speakerDetailImg))
            imgView.isUserInteractionEnabled = true
            imgView.addGestureRecognizer(speakerDetailImg)

            scrollSpeakerContainer.addSubview(imgView)
            scrollSpeakerContainer.addSubview(titleLbl)
        }
    }
    
    @objc func speakerDetailLabel(sender:UIGestureRecognizer) {
        guard let tag = (sender.view as? UILabel)?.tag else {
            // return
            //   let tag = (sender.view as? UIImageView)?.tag
            return
        }
        
        performSegue(withIdentifier: "speakertimelinedetail", sender: speakerList[tag - 1])
        
    }
    
    @objc func speakerDetailImg(sender:UIGestureRecognizer) {
        guard let tag = (sender.view as? UIImageView)?.tag else {
            return
        }
        performSegue(withIdentifier: "speakertimelinedetail", sender: speakerList[tag - 1])
    }
    
    //MARK:- Error Methods
    @objc func errorSignLikeAlert(){
    let alert = UIAlertController(title: "Error", message: "You must sign in to Do this Part", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
    }
    
    @objc func errorAlert(){
        scrollSponserContainer.isHidden = true
        scrollSpeakerContainer.isHidden = true
        hideShowFixedSponser(Order: false)
        hideShowFixedSpeaker(Order: false)
        // is this error for Interner only ??
        let alert = UIAlertController(title: "Error!", message: Service.errorConnection, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
     
    }
    
    
    //MARK:- SpeakerDataLoading
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
            while index < 8 {
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
             
            }
                if !(self.speakerList.isEmpty){
                    self.loadSpeakerScroll()
            self.speakerName1.text = self.speakerList[0].name
            self.speakerName2.text = self.speakerList[1].name
            self.speakerName3.text = self.speakerList[2].name
            self.speakerName4.text = self.speakerList[3].name
              //  if self.speakerList[0].speakerImageUrl != nil{
            Helper.loadImagesKingFisher(imgUrl: self.speakerList[0].speakerImageUrl!, ImgView: self.speakerImg1)
            Helper.loadImagesKingFisher(imgUrl: self.speakerList[1].speakerImageUrl!, ImgView: self.speakerImg2)
            Helper.loadImagesKingFisher(imgUrl: self.speakerList[2].speakerImageUrl!, ImgView: self.speakerImg3)
            Helper.loadImagesKingFisher(imgUrl: self.speakerList[3].speakerImageUrl!, ImgView: self.speakerImg4)

                }
            } else {
                // if no data in speaker what doing ??
            }
        }
    }
    
    //MARK:- SponserDataLoading
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
            while index < 8 {
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
                    self.loadSponserScroll()

            self.sponserName1.text = self.sponserList[0].sponserName
            self.sponserName2.text = self.sponserList[1].sponserName
            self.sponserName3.text = self.sponserList[2].sponserName
            self.sponserName4.text = self.sponserList[3].sponserName
            Helper.loadImagesKingFisher(imgUrl: self.sponserList[0].sponserImageUrl!, ImgView: self.sponserImg1)
            Helper.loadImagesKingFisher(imgUrl: self.sponserList[1].sponserImageUrl!, ImgView: self.sponserImg2)
            Helper.loadImagesKingFisher(imgUrl: self.sponserList[2].sponserImageUrl!, ImgView: self.sponserImg3)
            Helper.loadImagesKingFisher(imgUrl: self.sponserList[3].sponserImageUrl!, ImgView: self.sponserImg4)
         
        }
        } else {
            // if no data in sponser what doing ??

            }
        }
    }
    //MARK:- AboutDataLoading
    func loadAboutData()  {
        if let casheAbout = Helper.getCITAbout(){
            self.homeAbout.text = casheAbout

        } else {
        Service.getService(url: (URLs.getAbout)) {
            (response) in
            print("this is About ")
            print(response)

            let json = JSON(response)
            
            let result = json["AboutInfo"].string
            if result != nil && !(result!.isEmpty) && result != ""{
                let resultHtml = result?.htmlToString
                self.homeAbout.text = resultHtml
                Helper.saveCITAbout(CITAbout: resultHtml!)
            } else {
                // if no data in posts what doing ??
                
            }
        }
     }
    }
    
    //MARK:- PostsDataLoading
    func loadPostsData()  {
        if let  apiToken  = Helper.getApiToken() {
            Service.getServiceWithAuth(url: (URLs.getAllPosts)) {
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
                        let post_Type = result[index]["postType"].string
                        
                        let post_LikeCount = result[index]["likeCount"].int
                        let post_Comments = result[index]["Comments"]
                        
                        var iDCommentNotNull = true
                        var indexComment = 0
                        while iDCommentNotNull {
                            let comment_Auth = post_Comments[indexComment]["author"].string
                            if comment_Auth == nil || comment_Auth?.trimmed == "" || comment_Auth == "null" || comment_Auth == "nil" {
                                iDCommentNotNull = false
                                break
                            }
                            let comment_AutherPic = post_Comments[indexComment]["autherPic"].string
                            let comment_Discription = post_Comments[indexComment]["commentDiscription"].string
                            self.commentNewsFeedList.append(CommentsNewsFeed(Author: comment_Auth ?? "", AutherPic: comment_AutherPic ?? "", CommentDiscription: comment_Discription ?? ""))
                            indexComment = indexComment + 1
                            
                        }
                        let post_Islike = result[index]["Islike"].bool
                        let post_SharingLink = result[index]["sharingLink"].string
                        let post_Image = result[index]["image"].string
                        
                        
                        self.newsFeedList.append(NewsFeedData(Post_ID: post_ID ?? "", Post_Author: post_Author ?? "", Post_AutherPicture: post_AutherPic ?? "", Post_VideoURl: post_VedioURl ?? "" , Post_Discription: post_Discription ?? "", Post_LikeCount: post_LikeCount ?? 0, Post_Comments: self.commentNewsFeedList, Post_Islike: post_Islike ?? false, Post_SharingLink: post_SharingLink ?? "", Post_Image: post_Image ?? "", Post_Type: post_Type ?? ""))
                        self.masterDataNewsFeedList.append(NewsFeedData(Post_ID: post_ID ?? "", Post_Author: post_Author ?? "", Post_AutherPicture: post_AutherPic ?? "", Post_VideoURl: post_VedioURl ?? "" , Post_Discription: post_Discription ?? "", Post_LikeCount: post_LikeCount ?? 0, Post_Comments: self.commentNewsFeedList, Post_Islike: post_Islike ?? false, Post_SharingLink: post_SharingLink ?? "", Post_Image: post_Image ?? "", Post_Type: post_Type ?? ""))
                        if post_Type == "text" {
                            self.textNewsFeedList.append(NewsFeedData(Post_ID: post_ID ?? "", Post_Author: post_Author ?? "", Post_AutherPicture: post_AutherPic ?? "", Post_VideoURl: post_VedioURl ?? "" , Post_Discription: post_Discription ?? "", Post_LikeCount: post_LikeCount ?? 0, Post_Comments: self.commentNewsFeedList, Post_Islike: post_Islike ?? false, Post_SharingLink: post_SharingLink ?? "", Post_Image: post_Image ?? "", Post_Type: post_Type ?? ""))
                        } else if post_Type == "video_text" {
                            self.videoTextNewsFeedList.append(NewsFeedData(Post_ID: post_ID ?? "", Post_Author: post_Author ?? "", Post_AutherPicture: post_AutherPic ?? "", Post_VideoURl: post_VedioURl ?? "" , Post_Discription: post_Discription ?? "", Post_LikeCount: post_LikeCount ?? 0, Post_Comments: self.commentNewsFeedList, Post_Islike: post_Islike ?? false, Post_SharingLink: post_SharingLink ?? "", Post_Image: post_Image ?? "", Post_Type: post_Type ?? ""))
                        }
                        else if post_Type == "video" {
                            self.videoNewsFeedList.append(NewsFeedData(Post_ID: post_ID ?? "", Post_Author: post_Author ?? "", Post_AutherPicture: post_AutherPic ?? "", Post_VideoURl: post_VedioURl ?? "" , Post_Discription: post_Discription ?? "", Post_LikeCount: post_LikeCount ?? 0, Post_Comments: self.commentNewsFeedList, Post_Islike: post_Islike ?? false, Post_SharingLink: post_SharingLink ?? "", Post_Image: post_Image ?? "", Post_Type: post_Type ?? ""))
                        }
                        index = index + 1
                        self.timeLineCollView.reloadData()
                        // }
                    }
                } else {
                    // if no data in posts what doing ??
                    
                }
            }
            
        } else {
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
                let post_Type = result[index]["postType"].string

                let post_LikeCount = result[index]["likeCount"].int
                let post_Comments = result[index]["Comments"]
                
                var iDCommentNotNull = true
                var indexComment = 0
                while iDCommentNotNull {
                    let comment_Auth = post_Comments[indexComment]["author"].string
                    if comment_Auth == nil || comment_Auth?.trimmed == "" || comment_Auth == "null" || comment_Auth == "nil" {
                        iDCommentNotNull = false
                        break
                    }
                    let comment_AutherPic = post_Comments[indexComment]["autherPic"].string
                    let comment_Discription = post_Comments[indexComment]["commentDiscription"].string
                  self.commentNewsFeedList.append(CommentsNewsFeed(Author: comment_Auth ?? "", AutherPic: comment_AutherPic ?? "", CommentDiscription: comment_Discription ?? ""))
                    indexComment = indexComment + 1
                   
                }
                let post_Islike = result[index]["Islike"].bool
                let post_SharingLink = result[index]["sharingLink"].string
                let post_Image = result[index]["image"].string
                
                
                self.newsFeedList.append(NewsFeedData(Post_ID: post_ID ?? "", Post_Author: post_Author ?? "", Post_AutherPicture: post_AutherPic ?? "", Post_VideoURl: post_VedioURl ?? "" , Post_Discription: post_Discription ?? "", Post_LikeCount: post_LikeCount ?? 0, Post_Comments: self.commentNewsFeedList, Post_Islike: post_Islike ?? false, Post_SharingLink: post_SharingLink ?? "", Post_Image: post_Image ?? "", Post_Type: post_Type ?? ""))
                  self.masterDataNewsFeedList.append(NewsFeedData(Post_ID: post_ID ?? "", Post_Author: post_Author ?? "", Post_AutherPicture: post_AutherPic ?? "", Post_VideoURl: post_VedioURl ?? "" , Post_Discription: post_Discription ?? "", Post_LikeCount: post_LikeCount ?? 0, Post_Comments: self.commentNewsFeedList, Post_Islike: post_Islike ?? false, Post_SharingLink: post_SharingLink ?? "", Post_Image: post_Image ?? "", Post_Type: post_Type ?? ""))
                if post_Type == "text" {
                        self.textNewsFeedList.append(NewsFeedData(Post_ID: post_ID ?? "", Post_Author: post_Author ?? "", Post_AutherPicture: post_AutherPic ?? "", Post_VideoURl: post_VedioURl ?? "" , Post_Discription: post_Discription ?? "", Post_LikeCount: post_LikeCount ?? 0, Post_Comments: self.commentNewsFeedList, Post_Islike: post_Islike ?? false, Post_SharingLink: post_SharingLink ?? "", Post_Image: post_Image ?? "", Post_Type: post_Type ?? ""))
                } else if post_Type == "video_text" {
                    self.videoTextNewsFeedList.append(NewsFeedData(Post_ID: post_ID ?? "", Post_Author: post_Author ?? "", Post_AutherPicture: post_AutherPic ?? "", Post_VideoURl: post_VedioURl ?? "" , Post_Discription: post_Discription ?? "", Post_LikeCount: post_LikeCount ?? 0, Post_Comments: self.commentNewsFeedList, Post_Islike: post_Islike ?? false, Post_SharingLink: post_SharingLink ?? "", Post_Image: post_Image ?? "", Post_Type: post_Type ?? ""))
                }
                else if post_Type == "video" {
                    self.videoNewsFeedList.append(NewsFeedData(Post_ID: post_ID ?? "", Post_Author: post_Author ?? "", Post_AutherPicture: post_AutherPic ?? "", Post_VideoURl: post_VedioURl ?? "" , Post_Discription: post_Discription ?? "", Post_LikeCount: post_LikeCount ?? 0, Post_Comments: self.commentNewsFeedList, Post_Islike: post_Islike ?? false, Post_SharingLink: post_SharingLink ?? "", Post_Image: post_Image ?? "", Post_Type: post_Type ?? ""))
                }
                index = index + 1
                self.timeLineCollView.reloadData()
           // }
            }
            } else {
                // if no data in posts what doing ??

            }
            }
    }
    }
    
    //MARK:- CollectionViewMethods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsFeedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsfeedcell", for: indexPath) as! NewFeedsCell
        cell.setNewsFeedCeel(NewsfeedList: newsFeedList[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      //  NewsDetails.PostOrNews == true
        print(newsFeedList[indexPath.row])
        performSegue(withIdentifier: "timelinepostdetail", sender: newsFeedList[indexPath.row])

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dis = segue.destination as? postsDetails {
            if let favDetail = sender as? NewsFeedData {
                dis.singlePostsItem = favDetail
            }
        }
        if let spons = segue.destination as? NetworkDetailsVC {
            if let favDetail = sender as? Sponsers {
                spons.singleSponserItem = favDetail
            }
        }
        if let speak = segue.destination as? SpeakerProfileVC {
            if let favDetail = sender as? Speakers {
                speak.singleItem = favDetail
            }
        }
    }
    
    //MARK:- Nav Buttons
    @IBAction func moreSponsers(_ sender: Any) {
        MenuViewController.sponserEventOrMenu = true
        performSegue(withIdentifier: "sponserspage", sender: nil)
    }
    @IBAction func btnAgenda(_ sender: Any) {
         performSegue(withIdentifier: "agendabarbtn", sender: nil)
    }
    
    @IBAction func moreSpeaker(_ sender: Any) {
        MenuViewController.speakerEventOrMenu = true
        performSegue(withIdentifier: "speakerpage", sender: nil)
    }
    
    //MARK:- Filtters & Control Methods
    @IBAction func allTypePosts(_ sender: Any) {
        newsFeedList.removeAll()
        newsFeedList = masterDataNewsFeedList
        timeLineCollView.reloadData()
    }
    @IBAction func videoPostsType(_ sender: Any) {
        newsFeedList.removeAll()
        newsFeedList = videoNewsFeedList
        timeLineCollView.reloadData()
    }
    
    @IBAction func videoTextPostsType(_ sender: Any) {
        newsFeedList.removeAll()
        newsFeedList = videoTextNewsFeedList
        timeLineCollView.reloadData()
    }
    @IBAction func textPostType(_ sender: Any) {
        newsFeedList.removeAll()
        newsFeedList = textNewsFeedList
        timeLineCollView.reloadData()
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

//
//  TimeLineHomeVC.swift
//  Elshams
//
//  Created by mac on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class TimeLineHomeVC: BaseViewController , UICollectionViewDataSource , UICollectionViewDelegate {
   
    @IBOutlet weak var homeLogo: UIImageView!
    
    @IBOutlet weak var homeNameAbout: UIImageView!
    
    @IBOutlet weak var homeAbout: UITextView!
    var newsFeedList = Array<NewsFeedData>()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        newsFeedList.append(NewsFeedData(UserPostName: "khaled bakar", VideoPostUrl: "https://www.youtube.com/embed/Kmq6JU-1N9M", UserPostImage: "profile1"))
        newsFeedList.append(NewsFeedData(UserPostName: "khaled bakar bardo", VideoPostUrl: "https://www.youtube.com/embed/Kmq6JU-1N9M", UserPostImage: "profile2"))
        newsFeedList.append(NewsFeedData(UserPostName: "khaled bakar 3", VideoPostUrl: "https://www.youtube.com/embed/Kmq6JU-1N9M", UserPostImage: "avatar"))
        newsFeedList.append(NewsFeedData(UserPostName: "khaled bakar 4", VideoPostUrl: "https://www.youtube.com/embed/Kmq6JU-1N9M", UserPostImage: "avatar"))

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
    
    @IBAction func moreSpeaker(_ sender: Any) {
        MenuViewController.speakerEventOrMenu = true

        performSegue(withIdentifier: "speakerpage", sender: nil)
    }
    
    @IBAction func btnPost(_ sender: Any) {
        
    }
    
    @IBAction func btnAttachPost(_ sender: Any) {
        print("attachment")
    }
    
    @IBAction func btnCameraPost(_ sender: Any) {
        print("btnCameraPost")

    }
    
    @IBAction func btnGalleryPost(_ sender: Any) {
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

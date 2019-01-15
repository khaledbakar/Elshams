//
//  TimeLineHomeVC.swift
//  Elshams
//
//  Created by mac on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class TimeLineHomeVC: BaseViewController , UICollectionViewDataSource , UICollectionViewDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate {
    @IBOutlet weak var scrollTimeLineView: UIScrollView!
    
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
        newsFeedList.append(NewsFeedData(UserPostName: "khaled bakar", VideoPostUrl: "https://www.youtube.com/embed/Kmq6JU-1N9M", UserPostImage: "profile1", TypePost: "video", ImagePost: UIImage(named: "avatar")!))
        newsFeedList.append(NewsFeedData(UserPostName: "khaled bakar bardo", VideoPostUrl: "https://www.youtube.com/embed/Kmq6JU-1N9M", UserPostImage: "profile2", TypePost: "video", ImagePost: UIImage(named: "avatar")!))
        newsFeedList.append(NewsFeedData(UserPostName: "khaled bakar 3", VideoPostUrl: "https://www.youtube.com/embed/Kmq6JU-1N9M", UserPostImage: "avatar", TypePost: "video", ImagePost: UIImage(named: "avatar")!))
        newsFeedList.append(NewsFeedData(UserPostName: "khaled bakar 4", VideoPostUrl: "https://www.youtube.com/embed/Kmq6JU-1N9M", UserPostImage: "avatar", TypePost: "video", ImagePost: UIImage(named: "avatar")!))

        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        postText.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer)  {
        view.endEditing(true)
        self.scrollTimeLineView.endEditing(true)
        self.viewTimeLineView.endEditing(true)
        self.timeLineCollView.endEditing(true)
        self.postText.endEditing(true)
    }
    
    @objc func keyboardWillChange(notification: Notification){
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if  notification.name == Notification.Name.UIKeyboardWillShow ||
            notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0
        }
        print("Keyboard will show \(notification.name.rawValue)")
        //   view.frame.origin.y = -150
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.scrollTimeLineView.endEditing(true)
        self.viewTimeLineView.endEditing(true)
        self.timeLineCollView.endEditing(true)
        self.postText.endEditing(true)


        view.frame.origin.y = 0
    }
    
    func hideKyebad() {
        postText.resignFirstResponder()
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

        performSegue(withIdentifier: "speakerpage", sender: nil)
    }
    
    @IBAction func btnPost(_ sender: Any) {
        newsFeedList.append(NewsFeedData(UserPostName: "Khaled", VideoPostUrl: postText.text! , UserPostImage: "avatar", TypePost: "text", ImagePost: UIImage(named: "avatar")!))
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
            newsFeedList.append(NewsFeedData(UserPostName: "Khaled", VideoPostUrl: "", UserPostImage: "avatar", TypePost: "photo", ImagePost: image))
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

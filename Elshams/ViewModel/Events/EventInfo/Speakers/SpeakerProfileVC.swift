//
//  SpeakerProfileVC.swift
//  Elshams
//
//  Created by mac on 12/5/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI
//import AlamofireImage
import Alamofire
import SwiftyJSON

class SpeakerProfileVC: UIViewController {
    var singleItem:Speakers?
    var speakerSessionsList = Array<SpeakerSeasions>()
    var sessionCounterIndex : Int = 0
    var sessionFirstConstatContraint : CGFloat?

    @IBOutlet weak var nextBackSessionsContainer: UIView!
    @IBOutlet weak var nextBtnSession: UIButton!
    @IBOutlet weak var backBtnSession: UIButton!
    @IBOutlet weak var nextImgSession: UIImageView!
    
    @IBOutlet weak var backImgSession: UIImageView!
    
    
    @IBOutlet weak var informatonViewContainer: UIView!
    @IBOutlet weak var aboutTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var aboutViewContainer: UIView!
    @IBOutlet weak var sessionViewContainer: UIView!
    @IBOutlet weak var sessionTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var speakerName: UILabel!
    @IBOutlet weak var speakerEmail: UILabel!
    @IBOutlet weak var aboutSpeaker: UITextView!
   // @IBOutlet weak var speakerSecSName: UILabel!
    @IBOutlet weak var speakerFSLocation: UILabel!
    @IBOutlet weak var connectColor: UIView!
    
   // @IBOutlet weak var speakerSecSTime: UILabel!
  //  @IBOutlet weak var speakerSecSLocation: UILabel!
    @IBOutlet weak var speakerFSTime: UILabel!
    @IBOutlet weak var speakerFSName: UILabel!
  //  @IBOutlet weak var speakerFacebook: UILabel!
    @IBOutlet weak var speakerWebsite: UILabel!
    @IBOutlet weak var speakerPhone: UILabel!
    @IBOutlet weak var activeNow: UILabel!
    @IBOutlet weak var speakerJobTitle: UILabel!
    @IBOutlet weak var speakerProfileImg: UIImageView!
    var phoneNumber:String?
    var email:String?
    var faceBookLinkEdinNow:String?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speakerProfileImg.layer.cornerRadius = speakerProfileImg.frame.width / 2
        speakerProfileImg.clipsToBounds = true
        connectColor.layer.cornerRadius = connectColor.frame.width / 2
        connectColor.clipsToBounds = true
        speakerName.text = singleItem?.name
        speakerJobTitle.text = singleItem?.jobTitle
        speakerPhone.isHidden = true
        
        sessionFirstConstatContraint = sessionTopConstraints.constant
        
        if singleItem?.speakerImageUrl != nil {
            Helper.loadImagesKingFisher(imgUrl: (singleItem?.speakerImageUrl)!, ImgView: speakerProfileImg)
        }
        
        phoneNumber = singleItem?.contectInforamtion!["phone"] as! String
        email = singleItem?.contectInforamtion!["Email"] as! String
        faceBookLinkEdinNow = singleItem?.contectInforamtion!["linkedin"] as! String
        speakerPhone.text = phoneNumber
        
        if faceBookLinkEdinNow == nil || faceBookLinkEdinNow == ""{
           // speakerFacebook.text = "Na"
        }else {
          //  speakerFacebook.text = faceBookLinkEdinNow

        }
        
        speakerEmail.text = email
        speakerWebsite.text = faceBookLinkEdinNow
        if singleItem?.about == nil  || singleItem?.about == "" ||  singleItem?.about == "About"{
            noAboutMethod()
        } else {
            aboutViewContainer.isHidden = false
            aboutSpeaker.text = singleItem?.about

        }
        sessionViewContainer.isHidden = true
        
        connectColor.isHidden = true
        connectColor.backgroundColor  = UIColor.green
        activeNow.isHidden = true
        
        

     
        let tapCall = UITapGestureRecognizer(target: self, action: #selector(SpeakerProfileVC.tapCallFunc))
        speakerPhone.isUserInteractionEnabled = true
        speakerPhone.addGestureRecognizer(tapCall)
        
        let tapLink = UITapGestureRecognizer(target: self, action: #selector(SpeakerProfileVC.tapOpenLinkFunc))
        speakerWebsite.isUserInteractionEnabled = true
        speakerWebsite.addGestureRecognizer(tapLink)
       
        
        let tapMail = UITapGestureRecognizer(target: self, action: #selector(SpeakerProfileVC.tapMailFunc))
        speakerEmail.isUserInteractionEnabled = true
        speakerEmail.addGestureRecognizer(tapMail)
        
   
        
    }
    override func viewWillAppear(_ animated: Bool) {
            UIApplication.shared.isStatusBarHidden = false
        loadAllSpeakerData()
    }
    
    func loadAllSpeakerData()  {
        Service.getService(url: "\(URLs.getSpeakerDetail)/\((singleItem?.speaker_id)!)") {
            (response) in
            print(response)
            let json = JSON(response)
            let result = json
            if !(result.isEmpty){
                    let speaker_ID = result["ID"].string
                    let speaker_Name = result["name"].string
                    let speaker_JobTitle = result["jobTitle"].string
                    let speaker_CompanyName = result["companyName"].string
                    let speaker_ImageUrl = result["imageUrl"].string
                    let speaker_About = result["about"].string
                    let speaker_ContectInforamtion = result["ContectInforamtion"].dictionaryObject
                    let speaker_Email = result["ContectInforamtion"]["Email"].string
                    let speaker_Linkedin = result["ContectInforamtion"]["linkedin"].string
                    let speaker_Phone = result["ContectInforamtion"]["phone"].string
                    let contect = ["Email": "","linkedin": "","phone": ""]
                    let speaker_Sessions = result["Seassions"]
                
                var iDNotNull = true
                var index = 0
                while iDNotNull {
                    let session_ID = speaker_Sessions[index]["ID"].string
                    if session_ID == nil || session_ID?.trimmed == "" || session_ID == "null" || session_ID == "nil" {
                       iDNotNull = false
                        break
                    }
                    let session_Title = speaker_Sessions[index]["Title"].string
                    let session_Location = speaker_Sessions[index]["Location"].string
                    let session_Time = speaker_Sessions[index]["Time"].string

                    self.speakerSessionsList.append(SpeakerSeasions(Session_id: session_ID ?? "", Session_Title: session_Title ?? "", Session_Location: session_Location ?? "", Session_Time: session_Time ?? ""))
                    index = index + 1
                }
                self.speakerPhone.text = speaker_Phone
                self.speakerEmail.text = speaker_Email
                self.speakerWebsite.text = speaker_Linkedin
                if speaker_About == nil || speaker_About == "" {
                   //self.noAboutMethod()
                    print("no about")
                } else {
                    self.showAboutMethod()
                    self.aboutSpeaker.text = speaker_About?.htmlToString

                }
                if !(self.speakerSessionsList.isEmpty) {
                  //  for ind in 0..<self.speakerSessionsList.count{
                        //if ind == 0 {
                    self.sessionViewContainer.isHidden = false
                    if self.speakerSessionsList.count == 1{
                        self.nextBackSessionsContainer.isHidden = true
                        }
                   else if self.speakerSessionsList.count == 2{
                        self.nextBackSessionsContainer.isHidden = false
                        self.backBtnSession.isHidden = true
                        self.backImgSession.isHidden = true

                    }
                        
                    else {
                    self.nextBackSessionsContainer.isHidden = false
                        self.backBtnSession.isHidden = true
                        self.backImgSession.isHidden = true
                }
                            self.speakerFSName.text = self.speakerSessionsList[0].session_Title
                            self.speakerFSTime.text = self.speakerSessionsList[0].session_Time
                            self.speakerFSLocation.text = self.speakerSessionsList[0].session_Location

                } else {
                    // session view hidden
                    self.noSessionsMethod()
                }
               
                }
            
            else {
                let alert = UIAlertController(title: "No Data", message: "No Data found till now", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
  
    @objc func tapFacebookLinkFunc(sender:UIGestureRecognizer) {
        if let openURL = URL(string: "twitter://"){
        let canOpen = UIApplication.shared.canOpenURL(openURL)
            print("\(canOpen)")
        }
       // let apppName = "Facebook"
         //let apppName = "fb://feed"
        let apppName = "fb"
        

        let appScheme = "\(apppName)://profile"
      

        let appSchemeUrl = URL(string: appScheme)
       
        if UIApplication.shared.canOpenURL(appSchemeUrl! as URL) {
            UIApplication.shared.open(appSchemeUrl!, options: [:], completionHandler: nil)
        }
        else {
            let alert = UIAlertController(title: "\(apppName) Error...", message: "the app named \(apppName) not found,please install it fia app store.", preferredStyle: .alert )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func tapMailFunc(sender:UIGestureRecognizer) {
        guard MFMailComposeViewController.canSendMail()
            else {
                return
        }
        let compser = MFMailComposeViewController()
        compser.mailComposeDelegate = self
        compser.setToRecipients([(email)!])
        compser.setSubject("Event User Want to connect")
        compser.setMessageBody("", isHTML: false)
        present(compser, animated: true, completion: nil)
        
    }
    
    @objc func tapCallFunc(sender:UIGestureRecognizer) {
        if phoneNumber != nil {
       PhoneCall.makeCall(PhoneNumber: (phoneNumber)!)
        guard let numberString = phoneNumber,let url = URL(string: "telprompt://\(numberString)")
            else {
            return
        }
        UIApplication.shared.open(url)
    }
    }
    
    @IBAction func backSessionMethod(_ sender: Any) {
        if sessionCounterIndex > 0   {
            print(sessionCounterIndex)
            sessionCounterIndex = sessionCounterIndex - 1
            nextBtnSession.isHidden = false
            nextImgSession.isHidden = false
            if sessionCounterIndex == 0 {
                backImgSession.isHidden = true
                backBtnSession.isHidden = true
            }
            
        } else if sessionCounterIndex == 0 {
            backImgSession.isHidden = true
            backBtnSession.isHidden = true
            nextBtnSession.isHidden = false
            nextImgSession.isHidden = false
        }
        if !(speakerSessionsList.isEmpty) { // != nil
            speakerFSName.text = speakerSessionsList[sessionCounterIndex].session_Title
            speakerFSTime.text = speakerSessionsList[sessionCounterIndex].session_Time
            speakerFSLocation.text = speakerSessionsList[sessionCounterIndex].session_Location

        }
        
    }
    
    @IBAction func nextSessionMethod(_ sender: Any) {
        if sessionCounterIndex < speakerSessionsList.count - 1 {
            print(sessionCounterIndex)
            sessionCounterIndex = sessionCounterIndex + 1
            backImgSession.isHidden = false
            backBtnSession.isHidden = false
            if sessionCounterIndex == speakerSessionsList.count - 1 {
                nextBtnSession.isHidden = true
                nextImgSession.isHidden = true
            }
            
        } else if sessionCounterIndex == speakerSessionsList.count - 1 {
            backImgSession.isHidden = false
            backBtnSession.isHidden = false
            nextBtnSession.isHidden = true
            nextImgSession.isHidden = true
        }
        if !(speakerSessionsList.isEmpty) { // != nil
            speakerFSName.text = speakerSessionsList[sessionCounterIndex].session_Title
            speakerFSTime.text = speakerSessionsList[sessionCounterIndex].session_Time
            speakerFSLocation.text = speakerSessionsList[sessionCounterIndex].session_Location
        }
    }
    //MARK:- Shw/HideContainers
    func noAboutMethod()  {
        aboutViewContainer.isHidden = true
        sessionTopConstraints.constant = -(aboutViewContainer.frame.height) + (sessionTopConstraints.constant)

    }
    func showAboutMethod()  {
        aboutViewContainer.isHidden = false
        sessionTopConstraints.constant = sessionFirstConstatContraint!
        
    }
    func noSessionsMethod()  {
        sessionViewContainer.isHidden = true
    }
    
    @objc func tapOpenLinkFunc(sender:UIGestureRecognizer) {
       guard let url = URL(string: (speakerWebsite.text)!)
            else {
                return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        
    }
    
}

extension SpeakerProfileVC : MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            //show error alert
            controller.dismiss(animated: true, completion: nil)
        }
        switch  result {
        case .cancelled:
            print("cancelled")
        case .failed:
            print("failed")
        case .saved:
                print("saved")
        case .sent:
            print("sent")
       
    }
        controller.dismiss(animated: true, completion: nil)

    }
}

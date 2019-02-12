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
import AlamofireImage
import Alamofire
import SwiftyJSON

class SpeakerProfileVC: UIViewController {
    var singleItem:Speakers?
    var speakerSessionsList = Array<SpeakerSeasions>()

    @IBOutlet weak var speakerName: UILabel!
    @IBOutlet weak var speakerEmail: UILabel!
    @IBOutlet weak var aboutSpeaker: UITextView!
    @IBOutlet weak var speakerSecSName: UILabel!
    @IBOutlet weak var speakerFSLocation: UILabel!
    @IBOutlet weak var connectColor: UIView!
    
    @IBOutlet weak var speakerSecSTime: UILabel!
    @IBOutlet weak var speakerSecSLocation: UILabel!
    @IBOutlet weak var speakerFSTime: UILabel!
    @IBOutlet weak var speakerFSName: UILabel!
    @IBOutlet weak var speakerFacebook: UILabel!
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
        
        if singleItem?.speakerImageUrl != nil {
            imgUrl(imgUrl: (singleItem?.speakerImageUrl)!)
        }
        
        phoneNumber = singleItem?.contectInforamtion!["phone"] as! String
        email = singleItem?.contectInforamtion!["Email"] as! String
        faceBookLinkEdinNow = singleItem?.contectInforamtion!["linkedin"] as! String
        speakerPhone.text = phoneNumber
        speakerFacebook.text = faceBookLinkEdinNow
        speakerEmail.text = email
        speakerWebsite.text = faceBookLinkEdinNow
        aboutSpeaker.text = singleItem?.about
        connectColor.isHidden = true
        connectColor.backgroundColor  = UIColor.green
        activeNow.isHidden = true
        
        

      /*  if singleItem?.activeOrNot == true {
            connectColor.backgroundColor  = UIColor.green
            activeNow.text = "Now"
        }
        else {
            connectColor.backgroundColor = UIColor.red
            activeNow.text = "Offline"

        } */
        
       // speakerPhone.addGestureRecognizer(<#T##gestureRecognizer: UIGestureRecognizer##UIGestureRecognizer#>)
        let tapCall = UITapGestureRecognizer(target: self, action: #selector(SpeakerProfileVC.tapCallFunc))
        speakerPhone.isUserInteractionEnabled = true
        speakerPhone.addGestureRecognizer(tapCall)
        
        let tapLink = UITapGestureRecognizer(target: self, action: #selector(SpeakerProfileVC.tapOpenLinkFunc))
        speakerWebsite.isUserInteractionEnabled = true
        speakerWebsite.addGestureRecognizer(tapLink)
         //      speakerFacebook.isUserInteractionEnabled = true
      //  speakerFacebook.addGestureRecognizer(tapLink)
        
        let tapMail = UITapGestureRecognizer(target: self, action: #selector(SpeakerProfileVC.tapMailFunc))
        speakerEmail.isUserInteractionEnabled = true
        speakerEmail.addGestureRecognizer(tapMail)
        
        let tapFacebook = UITapGestureRecognizer(target: self, action: #selector(SpeakerProfileVC.tapFacebookLinkFunc))
        speakerFacebook.isUserInteractionEnabled = true
        speakerFacebook.addGestureRecognizer(tapFacebook)
        
     //   speakerProfileImg.image = UIImage(named: "\((singleItem?.speakerImage)!)")
     //   speakerJobTitle.text = singleItem?.jobTitle
        
    }
    override func viewWillAppear(_ animated: Bool) {
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
                self.speakerFacebook.text = speaker_Linkedin
                self.aboutSpeaker.text = speaker_About
                if !(self.speakerSessionsList.isEmpty) {
                    for ind in 0..<self.speakerSessionsList.count{
                        if ind == 0 {
                            self.speakerFSName.text = self.speakerSessionsList[ind].session_Title
                            self.speakerFSTime.text = self.speakerSessionsList[ind].session_Time
                            self.speakerFSLocation.text = self.speakerSessionsList[ind].session_Location
                            
                        }
                        else if ind == 1 {
                            self.speakerSecSName.text = self.speakerSessionsList[ind].session_Title
                            self.speakerSecSTime.text = self.speakerSessionsList[ind].session_Time
                            self.speakerSecSLocation.text = self.speakerSessionsList[ind].session_Location
                        }
                    }
               
                } else {
                    // session view hidden
                }
               
                }
            
            else {
                let alert = UIAlertController(title: "No Data", message: "No Data found till now", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func imgUrl(imgUrl:String)  {
        if imgUrl != nil {
            
       
        if let imagUrlAl = imgUrl as? String {
            Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                print(response)
                switch response.result {
                case .success(let value):
                if let image = response.result.value {
                    DispatchQueue.main.async{
                        self.speakerProfileImg.image = image
                    }
                }
                case .failure(let error):
                    print(error)
                }
            })
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
       // let appScheme = "\(apppName)://trikaofficial" can't open specficprofile
       /* let appName = "whatsapp"
         The link you need to open is “https://api.whatsapp.com/send?phone=YourPhoneNumberHere”
        ://khaledbakarphotography
         https://stackoverflow.com/questions/5707722/what-are-all-the-custom-url-schemes-supported-by-the-facebook-iphone-app
         profile?id=%@10000008024279
         profiles/[facebookID]
         let appScheme = "\(apppName)://send?phone=+201146803004"

        let appScheme = "\(appName)://send?phone=\+233204344223" */

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

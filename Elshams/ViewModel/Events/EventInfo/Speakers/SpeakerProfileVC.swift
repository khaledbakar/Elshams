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
        imgUrl(imgUrl: (singleItem?.speakerImageUrl)!)
        phoneNumber = singleItem?.contectInforamtion!["phone"] as! String
        email = singleItem?.contectInforamtion!["Email"] as! String
        faceBookLinkEdinNow = singleItem?.contectInforamtion!["linkedin"] as! String
        speakerPhone.text = phoneNumber
        speakerFacebook.text = faceBookLinkEdinNow
        speakerEmail.text = email
        speakerWebsite.text = faceBookLinkEdinNow
        aboutSpeaker.text = singleItem?.about
        connectColor.backgroundColor  = UIColor.green
        

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
    
    func imgUrl(imgUrl:String)  {
        if let imagUrlAl = imgUrl as? String {
            Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                print(response)
                if let image = response.result.value {
                    DispatchQueue.main.async{
                        self.speakerProfileImg.image = image
                    }
                }
            })
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
        compser.setMessageBody("i love your session ana want to connect with you in other deal", isHTML: false)
        present(compser, animated: true, completion: nil)
        
    }
    
    @objc func tapCallFunc(sender:UIGestureRecognizer) {
       PhoneCall.makeCall(PhoneNumber: (phoneNumber)!)
        guard let numberString = phoneNumber,let url = URL(string: "telprompt://\(numberString)")
            else {
            return
        }
        UIApplication.shared.open(url)
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

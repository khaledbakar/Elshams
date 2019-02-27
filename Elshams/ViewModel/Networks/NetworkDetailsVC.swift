//
//  NetworkDetailsVC.swift
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

class NetworkDetailsVC: UIViewController {
    
    @IBOutlet weak var viewAbout: UIView!
    @IBOutlet weak var viewProfile: UIView!
    let reachabilityManager = NetworkReachabilityManager(host: "https://baseURL.com")!
    var singleItem:Networks?
    var singleSponserItem:Sponsers?

    
    @IBOutlet weak var profileJobTitle: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileEMail: UILabel!
    @IBOutlet weak var profilePhone: UILabel!
    @IBOutlet weak var profileLinkedIn: UILabel!
    @IBOutlet weak var profileAbout: UITextView!
    
    var jobTitle: String?
    var image: String?
    var name: String?
    var eMail: String?
    var phone: String?
    var linkedIn: String?
    var about: String?
    
    var frameAbout = CGRect(x: 8.0, y: 385, width: 358.0, height: 206.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        profileName.text = ""
        profileJobTitle.text = ""
        profileAbout.text = ""
        profileEMail.text = ""
        profilePhone.text = ""
        profileLinkedIn.text = ""
        profileImg.layer.cornerRadius = profileImg.frame.width / 2
        profileImg.clipsToBounds = true
     
        
        viewAbout.frame = frameAbout
        loadSponser()
        
        let tapCall = UITapGestureRecognizer(target: self, action: #selector(NetworkDetailsVC.tapCallFunc))
        profilePhone.isUserInteractionEnabled = true
        profilePhone.addGestureRecognizer(tapCall)
    
        let tapMail = UITapGestureRecognizer(target: self, action: #selector(NetworkDetailsVC.tapMailFunc))
        profileEMail.isUserInteractionEnabled = true
        profileEMail.addGestureRecognizer(tapMail)
        
        let tapLinkedIn = UITapGestureRecognizer(target: self, action: #selector(NetworkDetailsVC.tapLinkedinFunc))
        profileLinkedIn.isUserInteractionEnabled = true
        profileLinkedIn.addGestureRecognizer(tapLinkedIn)
      
    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    
    func loadSponser()  {
        profileName.text = singleSponserItem?.sponserName
        let sposnserTypeRank = singleSponserItem?.sponsertype!["name"] as? String
        
     //   profileJobTitle.text = singleSponserItem?.sponserAddress
         profileJobTitle.text = sposnserTypeRank
        if singleSponserItem?.sponserAbout == "" || singleSponserItem?.sponserAbout == nil {
            viewAbout.isHidden = true
        } else {
            viewAbout.isHidden = false
            profileAbout.text = singleSponserItem?.sponserAbout?.htmlToString
        }
        
        eMail = singleSponserItem?.contectInforamtion!["Email"] as? String
        if eMail == nil || eMail == "" {
             profileEMail.text = "NA"
        } else {
            profileEMail.text = eMail

        }
        phone = singleSponserItem?.contectInforamtion!["phone"] as? String
        if phone == nil || phone == "" {
            profilePhone.text = "NA"
        }else {
        profilePhone.text = phone
        }
        
        linkedIn = singleSponserItem?.contectInforamtion!["linkedin"] as? String
        if linkedIn == nil || linkedIn == "" {
            profileLinkedIn.text = "NA"
            
        }else {
            profileLinkedIn.text = linkedIn

        }
        Helper.loadImagesKingFisher(imgUrl: (singleSponserItem?.sponserImageUrl)!, ImgView: self.profileImg)

    }

    func  loadSetData(personId:String)  {
        if let  apiToken  = Helper.getApiToken() {
        Service.getServiceWithAuth(url: "\(URLs.getPersonDetails)/\(personId)"){  // callback: <#T##(JSON?) -> ()#>)
              (response) in
            print(response)
            let result = JSON(response)
                let network_ID = result["ID"].string
                let network_Name = result["name"].string
                let network_JobTitle = result["jobTitle"].string
                let network_CompanyName = result["companyName"].string
                let network_ImageUrl = result["imageUrl"].string
                let network_Email = result["ContectInforamtion"]["Email"].string
                let network_Linkedin = result["ContectInforamtion"]["linkedin"].string
                let network_Phone = result["ContectInforamtion"]["phone"].string
                let network_about = result["about"].string
            self.profileName.text = network_Name
            Helper.loadImagesKingFisher(imgUrl: network_ImageUrl!, ImgView: self.profileImg)
            self.profileAbout.text = network_about
            self.profileEMail.text = network_Email
            self.profilePhone.text = network_Phone
            self.profileLinkedIn.text = network_Linkedin
            self.profileJobTitle.text = network_JobTitle
        }
        } else {
            let alert = UIAlertController(title: "Error", message: "You must sign in to Show this Part", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
      }
    }
    


    
    @objc func tapMailFunc(sender:UIGestureRecognizer) {
        let mailStr = (profileEMail.text)!
        if mailStr == "NA" || mailStr == "" {
            
        }else {
        guard MFMailComposeViewController.canSendMail()
            else {
                return
        }
        let compser = MFMailComposeViewController()
        compser.mailComposeDelegate = self
        compser.setToRecipients([mailStr])
        compser.setSubject("Event User Want to connect")
        compser.setMessageBody("", isHTML: false)
        present(compser, animated: true, completion: nil)
        
    }
    }
    @objc func tapCallFunc(sender:UIGestureRecognizer) {
        let phonelStr = (profilePhone.text)!
        if phonelStr == "NA" || phonelStr == "" {
            
        }else {
        PhoneCall.makeCall(PhoneNumber: phonelStr)
    }
    }
    
    @objc func tapLinkedinFunc(sender:UIGestureRecognizer) {
        /*  if let openURL = URL(string: "twitter://"){
         let canOpen = UIApplication.shared.canOpenURL(openURL)
         }
         let apppName = "linkedin"
         let appScheme = "\(apppName)://"
         let appSchemeUrl = URL(string: appScheme)
         
         if UIApplication.shared.canOpenURL(appSchemeUrl! as URL) {
         UIApplication.shared.open(appSchemeUrl!, options: [:], completionHandler: nil)
         }
         else {
         */
        //stop borwser till know who will check or add https to avoid safari error
        let linkStr = (profileLinkedIn.text)!
        if linkStr == "NA" || linkStr == "" {
            
        }else {
            guard let url = URL(string: linkStr)
                else {
                    return
            }
            
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
        }
        /*
         let alert = UIAlertController(title: "\(apppName) Error...", message: "the app named \(apppName) not found,please install it fia app store.", preferredStyle: .alert )
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         self.present(alert, animated: true, completion: nil)
         */
        // }
    }
}

extension NetworkDetailsVC : MFMailComposeViewControllerDelegate {
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

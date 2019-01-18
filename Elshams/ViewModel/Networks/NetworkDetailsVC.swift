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

class NetworkDetailsVC: UIViewController {
    
    @IBOutlet weak var viewAbout: UIView!
    @IBOutlet weak var viewProfile: UIView!
    
    var singleItem:Networks?
    
    @IBOutlet weak var profileJobTitle: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileEMail: UILabel!
    @IBOutlet weak var profilePhone: UILabel!
    @IBOutlet weak var profileLinkedIn: UILabel!
    @IBOutlet weak var profileAbout: UITextView!
    
    var frameAbout = CGRect(x: 8.0, y: 385, width: 358.0, height: 206.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        profileName.text = (singleItem?.name)!
        profileJobTitle.text = (singleItem?.jobTitle)!
        profileAbout.text = (singleItem?.about)!
        profileEMail.text = (singleItem?.mail)!
        profilePhone.text = (singleItem?.phone)!
        profileLinkedIn.text = (singleItem?.linkedInLink)!
        
        print((singleItem?.jobTitle)!)
        profileImg.layer.cornerRadius = profileImg.frame.width / 2
        profileImg.clipsToBounds = true
        profileImg.image = UIImage(named: "\((singleItem?.networkImage)!)")
        viewAbout.frame = frameAbout
        
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
    
    @objc func tapLinkedinFunc(sender:UIGestureRecognizer) {
        if let openURL = URL(string: "twitter://"){
            let canOpen = UIApplication.shared.canOpenURL(openURL)
        }
        let apppName = "linkedin"
        let appScheme = "\(apppName)://"
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
        compser.setToRecipients([(singleItem?.mail)!])
        compser.setSubject("Event User Want to connect")
        compser.setMessageBody("i love your session ana want to connect with you in other deal", isHTML: false)
        present(compser, animated: true, completion: nil)
        
    }
    
    @objc func tapCallFunc(sender:UIGestureRecognizer) {
        PhoneCall.makeCall(PhoneNumber: (singleItem?.phone)!)
    
    }
 
    /*
    @objc func tapOpenLinkFunc(sender:UIGestureRecognizer) {
        guard let url = URL(string: (singleItem?.website)!)
            else {
                return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        
    }
    
    */
    
    
  

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

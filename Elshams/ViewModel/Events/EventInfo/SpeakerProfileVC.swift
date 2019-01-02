//
//  SpeakerProfileVC.swift
//  Elshams
//
//  Created by mac on 12/5/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

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
    override func viewDidLoad() {
        super.viewDidLoad()
        speakerProfileImg.layer.cornerRadius = speakerProfileImg.frame.width / 2
        speakerProfileImg.clipsToBounds = true
        connectColor.layer.cornerRadius = connectColor.frame.width / 2
        connectColor.clipsToBounds = true
        speakerName.text = singleItem?.name
        speakerEmail.text = singleItem?.mail
        speakerPhone.text = singleItem?.phone
        speakerFacebook.text = singleItem?.facebookLink
        speakerWebsite.text = singleItem?.website
      
        speakerProfileImg.image = UIImage(named: "\((singleItem?.speakerImage)!)")
        speakerJobTitle.text = singleItem?.jobTitle
        
        

    }
    
  
    
}

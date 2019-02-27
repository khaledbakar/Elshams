//
//  Speakers.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
class Speakers {
    var name : String?
    var speaker_id : String?
    var about :String?
    var jobTitle : String?
    var companyName : String?
    var contectInforamtion :[String:Any]?
    var speakerImageUrl :String?
    var linkedIn : String?

/*
    var jobDescribition : String?
    var facebookLink :String?
    var phone :String?
    var mail :String?
    var website :String?
    var activeOrNot :Bool?*/


    init(SpeakerName:String,JobTitle:String,CompanyName:String,SpImageUrl:String,Speaker_id : String,ContectInforamtion:[String:Any],About:String,LinkedIn : String) {  //,FacebookInLink:String,Phone:String,Mail:String,About:String,Website:String,ActiveOrNot:Bool
        self.name = SpeakerName
        self.about = About
        self.jobTitle = JobTitle
        self.speakerImageUrl = SpImageUrl
        self.speaker_id = Speaker_id
        self.contectInforamtion = ContectInforamtion
        self.companyName = CompanyName
        self.linkedIn = LinkedIn

        /* self.facebookLink = FacebookInLink
         self.phone = Phone
         self.mail = Mail
         // self.jobDescribition = jobDescribition

         self.website = Website
         self.activeOrNot = ActiveOrNot */

    }
}

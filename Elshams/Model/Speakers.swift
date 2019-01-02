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
    var jobTitle : String?
    var jobDescribition : String?
    var speakerImage :String?
    var facebookLink :String?
    var phone :String?
    var mail :String?
    var about :String?
    var website :String?

    init(SpeakerName:String,JobTitle:String,jobDescribition:String,SpImage:String,FacebookInLink:String,Phone:String,Mail:String,About:String,Website:String) {
        self.name = SpeakerName
        self.jobDescribition = JobTitle
        self.jobTitle = jobDescribition
        self.speakerImage = SpImage
        self.facebookLink = FacebookInLink
        self.phone = Phone
        self.mail = Mail
        self.about = About
        self.website = Website
    }
}

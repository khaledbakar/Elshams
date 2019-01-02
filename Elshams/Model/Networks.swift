//
//  Networks.swift
//  Elshams
//
//  Created by mac on 12/5/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
class Networks {
    var name : String?
    var jobTitle : String?
    var jobDescribition : String?
    var networkImage :String?
    var linkedInLink :String?
    var phone :String?
    var mail :String?
    var about :String?
    
    init(NetworkName:String,JobTitle:String,jobDescribition:String,SpImage:String,LinkedInLink:String,Phone:String,Mail:String,About:String) {
        self.name = NetworkName
        self.jobDescribition = JobTitle
        self.jobTitle = jobDescribition
        self.networkImage = SpImage
        self.linkedInLink = LinkedInLink
        self.phone = Phone
        self.mail = Mail
        self.about = About
    }
}

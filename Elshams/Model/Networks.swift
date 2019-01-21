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
    var imageUrl :String?
    var companyName :String?
    var requestStatus:String?
    var requestSenderID:String?
    var network_Id :String?
    // var phone :String?
    //var mail :String?
    //var about :String?
    //  var linkedInLink :String?
  //  var jobDescribition : String?


    init(NetworkName:String,JobTitle:String,ImageUrl:String,CompanyName:String,NetworkID:String,RequestStatus:String,RequestSenderID:String) { //,jobDescribition:String,SpImage:String,LinkedInLink:String,Phone:String,Mail:String,About:String
        self.name = NetworkName
        self.jobTitle = JobTitle
        self.imageUrl = ImageUrl
        self.companyName = CompanyName
        self.network_Id = NetworkID
        self.requestStatus = RequestStatus
        self.requestSenderID = RequestSenderID
     /*   self.networkImage = SpImage
        self.linkedInLink = LinkedInLink
        self.phone = Phone
        self.mail = Mail
        self.about = About
        self.jobDescribition = jobDescribition */

    }
}

//
//  Sponsers.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
class Sponsers {
    var sponserID : String?
    var sponserOrder : String?

    var sponserName : String?
    var sponserAddress : String?
    var sponserImageUrl :String?
    var sponserAbout : String?
    var contectInforamtion :[String:Any]?
    var sponsertype :[String:Any]?
    

    init(SponserName:String,SponserAddress:String,SponserImageURL:String,SponserAbout:String,SponserID:String,SponserOrder : String,ContectInforamtion :[String:Any],Sponsertype :[String:Any]) {
        self.sponserName = SponserName
        self.sponserAddress = SponserAddress
        self.sponserImageUrl = SponserImageURL
        self.sponserAbout = SponserAbout
        self.sponserID = SponserID
        self.sponsertype = Sponsertype
        self.contectInforamtion = ContectInforamtion
        self.sponserOrder = SponserOrder
    }
}

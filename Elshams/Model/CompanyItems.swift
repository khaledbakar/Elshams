//
//  CompanyItems.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
class CompanyItems {
    var companyName:String?
    var companyAddress:String?
    var companyDetail:String?
    var companyImage:String?
    init(CompanyName:String,CompanyAddress:String,CompanyDetail:String,CompanyImage:String) {
        self.companyName = CompanyName
        self.companyAddress = CompanyAddress
        self.companyDetail = CompanyDetail
        self.companyImage = CompanyImage
        
    }
}

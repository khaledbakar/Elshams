//
//  AgendaSectionDate.swift
//  Elshams
//
//  Created by mac on 1/14/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
class AgendaSectionDate {
    var sectionDate : String?
    var sectionDateCounts : Int?
    var sectionDateIndex : Int?

    init(SectionDate:String,SectionDateCounts:Int,sectionDateIndex:Int) {
        self.sectionDate = SectionDate
        self.sectionDateCounts = SectionDateCounts
        self.sectionDateIndex = sectionDateIndex
    }

}

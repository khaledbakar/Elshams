//
//  AgendaHeadData.swift
//  Elshams
//
//  Created by mac on 1/22/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
class AgendaHeadData {
    var headTitle : String?
    var headDate : String?
    var headType : String?
    init(HeadTitle : String,HeadDate : String,HeadType : String) {
        self.headType = HeadType
        self.headDate = HeadDate
        self.headTitle = HeadTitle
    }
}

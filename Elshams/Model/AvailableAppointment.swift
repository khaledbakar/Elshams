//
//  AvailableAppointment.swift
//  Elshams
//
//  Created by mac on 1/29/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

class AvailableAppointment {
    var availableAppointmentDict :[String:Any]?
    var appoimentName :String?
    var appoimentID :String?
    init(AvailableAppointmentDict :[String:Any],AppoimentName :String,AppoimentID :String) {
        self.appoimentID = AppoimentID
        self.appoimentName = AppoimentName
        self.availableAppointmentDict = AvailableAppointmentDict
    }

}

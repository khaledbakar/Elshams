//
//  EventsData.swift
//  Elshams
//
//  Created by mac on 12/24/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
class EventsData {
    var eventsName:String?
    var eventsAddress:String?
    var eventsDetail:String?
    var eventsImage:String?
    init(EventsName:String,EventsAddress:String,EventsDetail:String,EventsImage:String) {
        self.eventsName = EventsName
        self.eventsAddress = EventsAddress
        self.eventsDetail = EventsDetail
        self.eventsImage = EventsImage
        
    }
}

//
//  Notifications.swift
//  Elshams
//
//  Created by mac on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
class Notifications {
    var notificationName : String?
    var notificationDetail : String?
    var notificationImageUrl : String?

    init(NotificationName:String,NotificationDetails:String,NotitficationImageUrl:String) {
        self.notificationName = NotificationName
        self.notificationDetail = NotificationDetails
        self.notificationImageUrl = NotitficationImageUrl
        
    }
}

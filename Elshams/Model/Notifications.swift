//
//  Notifications.swift
//  Elshams
//
//  Created by mac on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
class Notifications {
    var notification_Title : String?
    var notification_ID : String?
    var notification_Body : String?
    var notification_Status : String?
    var notification_Type : String?
    var notification_ImageUrl : String?

    init(NotificationTitle:String,NotificationID:String,NotitficationImageUrl:String,NotificationStatus:String,NotificationType:String,NotificationBody:String) {
        self.notification_Title = NotificationTitle
        self.notification_ID = NotificationID
        self.notification_Body = NotificationBody
        self.notification_Status = NotificationStatus
        self.notification_ImageUrl = NotitficationImageUrl
        self.notification_Type = NotificationType
        
    }
}

//
//  SpeakerSessions.swift
//  Elshams
//
//  Created by mac on 2/12/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
class SpeakerSeasions {
    var session_id : String?
    var session_Title : String?
    var session_Location : String?
    var session_Time : String?


    init(Session_id:String,Session_Title : String,Session_Location : String,Session_Time : String) {
        self.session_id = Session_id
        self.session_Title = Session_Title
        self.session_Location = Session_Location
        self.session_Time = Session_Time
        
        
        
    }
}

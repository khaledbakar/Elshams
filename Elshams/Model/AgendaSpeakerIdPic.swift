//
//  AgendaSpeakerIdPic.swift
//  Elshams
//
//  Created by mac on 2/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
class AgendaSpeakerIdPic {
    var speaker_id : String?
    var speakerImageUrl :String?

    init(SpImageUrl:String,Speaker_id : String) {  
        self.speakerImageUrl = SpImageUrl
        self.speaker_id = Speaker_id
       
    }
}

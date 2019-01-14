//
//  ProgramAgendaItems.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
class ProgramAgendaItems {
    var name : String?
    var startTime : String?
    var agendaDate : String?
    var endTime : String?
    var progLocation : String?
    var favouriteSession : Bool?
    var speakerOneImage :String?
    var speakerTwoImage :String?

    init(ProgramName:String,StartTime:String,EndTime:String,ProgLocation:String,SpImageOne:String,SpImageTwo:String,AgendaDate:String,FavouriteSession:Bool) {
        self.name = ProgramName
        self.startTime = StartTime
        self.endTime = EndTime
        self.progLocation = ProgLocation
        self.speakerOneImage = SpImageOne
        self.speakerTwoImage = SpImageTwo
        self.agendaDate = AgendaDate
        self.favouriteSession = FavouriteSession
        
        
    }
}

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
    var describtion : String?
    var startTime : String?
    var agendaDate : String?
    var endTime : String?
    var progLocation : String?
    var favouriteSession : Bool?
    var favouriteSessionStr : String?
    var speakerOneImage :String?
    var speakerTwoImage :String?
    var speaker_FK_Id :Int?
    var speaker_FK_Id_Str :String?


    init(ProgramName:String,StartTime:String,EndTime:String,ProgLocation:String,SpImageOne:String,SpImageTwo:String,AgendaDate:String,FavouriteSession:Bool,FavouriteSessionStr:String,Describtion:String,Speaker_FK_Id :Int,Speaker_FK_Id_Str :String) {
        self.name = ProgramName
        self.startTime = StartTime
        self.endTime = EndTime
        self.progLocation = ProgLocation
        self.speakerOneImage = SpImageOne
        self.speakerTwoImage = SpImageTwo
        self.agendaDate = AgendaDate
        self.favouriteSession = FavouriteSession
        self.favouriteSessionStr = FavouriteSessionStr
        self.describtion = Describtion
        self.speaker_FK_Id = Speaker_FK_Id
        self.speaker_FK_Id_Str = Speaker_FK_Id_Str

        
        
    }
}

//
//  ProgramAgendaItems.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
class ProgramAgendaItems {
    var seseionTitle : String?
    var agenda_ID :String?
    var agendaDate : String?
    var sessionTime : String?
    var progLocation : String?
    var favouriteSession : Bool?
    var favouriteSessionStr : String?
    var rondomColor :String?
    var agendaType :String?
    var speakersSession :[String:Any]?
    var speakersIdImg:[AgendaSpeakerIdPic]?

    

    
    init(Agenda_ID:String,SessionTitle:String,SessionTime:String,SessionLocation:String,SpeakersSession :[String:Any],AgendaDate:String,FavouriteSession:Bool,FavouriteSessionStr:String,RondomColor:String,AgendaType:String,SpeakersIdImg:[AgendaSpeakerIdPic]) {
        self.seseionTitle = SessionTitle
        self.sessionTime = SessionTime
        self.progLocation = SessionLocation
        self.agendaDate = AgendaDate
        self.favouriteSession = FavouriteSession
        self.favouriteSessionStr = FavouriteSessionStr
        self.speakersSession = SpeakersSession
        self.rondomColor = RondomColor
        self.agenda_ID = Agenda_ID
        self.agendaType = AgendaType
        self.speakersIdImg = SpeakersIdImg
       
      
/*
  init(ProgramName:String,StartTime:String,EndTime:String,ProgLocation:String,SpeakersSession :[String],SpImageOne:String,SpImageTwo:String,AgendaDate:String,FavouriteSession:Bool,FavouriteSessionStr:String,Describtion:String,Speaker_FK_Id :Int,Speaker_FK_Id_Str :String)
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
         self.speakersSession = SpeakersSession
         self.speaker_FK_Id = Speaker_FK_Id
         self.speaker_FK_Id_Str = Speaker_FK_Id_Str
         
         /*  var describtion : String?
         var startTime : String?
         var endTime : String?
         var speakerOneImage :String?
         var speakerTwoImage :String?
         var speakersSession :[String]?
         var speaker_FK_Id :Int?
         var speaker_FK_Id_Str :String?*/
         
 */
        
        
    }
}

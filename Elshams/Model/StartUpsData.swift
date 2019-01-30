
import Foundation
class StartUpsData {
    var startupName : String?
    var startup_id : String?
    var about :String?
    var startupImageUrl :String?
    var appoimentStatus : String?
    var appoimentTime : String?
    var contectInforamtion :[String:Any]?
    
    init(StartupName:String,StartupID:String,StartupImageURL:String,StartUpAbout:String,AppoimentStatus:String
        ,AppoimentTime:String,ContectInforamtion :[String:Any]) {
        self.startup_id = StartupID
        self.startupName = StartupName
        self.startupImageUrl = StartupImageURL
        self.about = StartUpAbout
        self.appoimentStatus = AppoimentStatus
        self.appoimentTime = AppoimentTime
        self.contectInforamtion = ContectInforamtion

    }
}



/*  var name : String?
 var startupAddress : String?
 var startupImage :String?
 var startUpLinkedIn :String?
 var startUpPhone :String?
 var startUpMail :String?
 var startUpAbout :String?
 var acceptedApointment : Bool?
 var pendingApointment : Bool?
 var acceptedApointmentStr : String?
 var pendingApointmentStr : String?
 var id_startUp : Int? */

/* self.name = StartupName
 self.startupAddress = StartupAddress
 self.startupImage = StartupImage
 self.startUpLinkedIn = StartUpLinkedIn
 self.startUpPhone = StartUpPhone
 self.startUpMail = StartUpMail
 self.startUpAbout = StartUpAbout
 self.acceptedApointment = AcceptedApointment
 self.pendingApointment = PendingApointment
 self.acceptedApointmentStr = AcceptedApointmentStr
 self.pendingApointmentStr = PendingApointmentStr
 self.id_startUp = Id_StartUp */


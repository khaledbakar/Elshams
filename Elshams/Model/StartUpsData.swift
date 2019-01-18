
import Foundation
class StartUpsData {
    var name : String?
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
    var id_startUp : Int?
    init(StartupName:String,StartupAddress:String,StartupImage:String,StartUpLinkedIn:String,StartUpPhone:String,StartUpMail:String,StartUpAbout:String,AcceptedApointment:Bool,PendingApointment:Bool,AcceptedApointmentStr:String,PendingApointmentStr:String,Id_StartUp:Int) {
        self.name = StartupName
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
        self.id_startUp = Id_StartUp

    }
}

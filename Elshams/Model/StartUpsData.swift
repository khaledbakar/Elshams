
import Foundation
class StartUpsData {
    var name : String?
    var startupAddress : String?
    var startupImage :String?
    var startUpLinkedIn :String?
    var startUpPhone :String?
    var startUpMail :String?
    var startUpAbout :String?


init(StartupName:String,StartupAddress:String,StartupImage:String,StartUpLinkedIn:String,StartUpPhone:String,StartUpMail:String,StartUpAbout:String) {
        self.name = StartupName
        self.startupAddress = StartupAddress
        self.startupImage = StartupImage
        self.startUpLinkedIn = StartUpLinkedIn
        self.startUpPhone = StartUpPhone
        self.startUpMail = StartUpMail
        self.startUpAbout = StartUpAbout

    }
}

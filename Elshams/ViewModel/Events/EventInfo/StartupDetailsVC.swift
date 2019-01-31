//
//  StartupDetailsVC.swift
//  Elshams
//
//  Created by mac on 12/5/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI
import Alamofire
import AlamofireImage
import SwiftyJSON

class StartupDetailsVC: UIViewController {
    var singleItem : StartUpsData?
    var startUpList = Array<StartUpsData>()
    var availableAppointmentList = Array<AvailableAppointment>()

    var startUp_Name : String?
    var startUp_Email : String?
    var startUp_Linkedin : String?
    var startUp_Phone : String?
    var startUp_About : String?
    var startUp_ImageURl : String?
    var startUp_Appoimentstatus : String?
    var startUp_AppoimentTime : String?
    
    
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var rescadualeView: UIView!
    
    @IBOutlet weak var sureMessageTxt: UILabel!
    
   // var appointmentBooking = ["saturday 9AM","saturday 10AM","saturday 11AM"]
    @IBOutlet weak var startUpLogo: UIImageView!
    
    @IBOutlet weak var popUpContainerView: UIView!
    @IBOutlet weak var startUpName: UILabel!
    @IBOutlet weak var startUpMail: UILabel!
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var aboutStartUp: UITextView!
    @IBOutlet weak var startUpLinkedIn: UILabel!
    @IBOutlet weak var startUpPhone: UILabel!
    
    @IBOutlet weak var informationTopConstraint: NSLayoutConstraint!
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var frameBtn = CGRect(x: 0, y: 0, width: 0, height: 0)

    @IBOutlet weak var profieView: UIView!
   static var  sechadualeBTNSend : Bool?
    var appointmentSelect:String?
    var appointmentSelect_Name:String?


    override func viewDidLoad() {
        super.viewDidLoad()
     
    /*    if singleItem?.pendingApointment == true {
            afterRescadualeFrame()
        }
       
       else if singleItem?.acceptedApointment == true {
            afterRescadualeFrame()
            //btn.is momken a3ml hidden l btn el rescaduale bs ana msh 3aml kda w shayf eno 3adi
            
        } else {
            defaultFrame()

        } */
        loadSessionData(StartUpID: (singleItem?.startup_id)!)
        loadavailableAppointment(StartUpID: (singleItem?.startup_id)!)
        if StartupDetailsVC.sechadualeBTNSend == true {
             popUpContainerView.isHidden = false
        } else
        {
             popUpContainerView.isHidden = true
        }
        StartupDetailsVC.sechadualeBTNSend = false

        startUpLogo.layer.cornerRadius = startUpLogo.frame.width / 2
        startUpLogo.clipsToBounds = true
    
        btnRightBar()
       
        
        let tapCall = UITapGestureRecognizer(target: self, action: #selector(StartupDetailsVC.tapCallFunc))
        startUpPhone.isUserInteractionEnabled = true
        startUpPhone.addGestureRecognizer(tapCall)
        
        let tapMail = UITapGestureRecognizer(target: self, action: #selector(StartupDetailsVC.tapMailFunc))
        startUpMail.isUserInteractionEnabled = true
        startUpMail.addGestureRecognizer(tapMail)
        
        let tapLinkedIn = UITapGestureRecognizer(target: self, action: #selector(StartupDetailsVC.tapLinkedInFunc))
        startUpLinkedIn.isUserInteractionEnabled = true
        startUpLinkedIn.addGestureRecognizer(tapLinkedIn)
        
      

    }
    
    

    func loadavailableAppointment(StartUpID:String)  {
        self.availableAppointmentList.removeAll()
        Service.getServiceWithAuth(url: "\(URLs.getAvaliableAppoiments)/\(StartUpID)") {
            (response) in
            print("this is SessionDetails ")
            print(response)
            let result = JSON(response)
            var iDNotNull = true
            var index = 0
            while iDNotNull {
                let avaAppointment_ID = result[index]["appoimentID"].string
                
                if avaAppointment_ID == nil || avaAppointment_ID?.trimmed == "" ||
                    avaAppointment_ID == "null" || avaAppointment_ID == "nil"{
                    iDNotNull = false
                    self.popUpViewMethod()
                    break
                }
            let avaAppointment = result[index].dictionaryObject
            let avaAppointment_Name = result[index]["appoimentName"].string
            
            let avaAppointmentOptinal = ["appoimentName": "",
                           "appoimentID": ""]
            self.availableAppointmentList.append(AvailableAppointment(AvailableAppointmentDict: avaAppointment ?? avaAppointmentOptinal, AppoimentName: avaAppointment_Name ?? "name", AppoimentID: avaAppointment_ID ?? "id"))
                index = index + 1
                
            }
        }
    }
    
    func loadSessionData(StartUpID:String)  {
        Service.getServiceWithAuth(url: "\(URLs.getStartupDetailsByID)/\(StartUpID)") {
            (response) in
            print("this is SessionDetails ")
            print(response)
            let result = JSON(response)
            // get startUp
            let startUp_ID = result["id"].string
            self.startUp_Name = result["startupName"].string
            self.startUp_About = result["about"].string
            self.startUp_ImageURl = result["imageURl"].string
            self.startUp_Appoimentstatus = result["appoimentstatus"].string
            self.startUp_AppoimentTime = result["AppoimentTime"].string
            let startUp_ContectInforamtion = result["ContectInforamtion"].dictionaryObject
             self.startUp_Email = result["ContectInforamtion"]["Email"].string
             self.startUp_Linkedin = result["ContectInforamtion"]["linkedin"].string
             self.startUp_Phone = result["ContectInforamtion"]["phone"].string
            
            let contect = ["Email": "",
                           "linkedin": "",
                           "phone": ""]
            
            self.startUpList.append(StartUpsData(StartupName: self.startUp_Name ?? "name", StartupID: startUp_ID ?? "ID", StartupImageURL: self.startUp_ImageURl ?? "Image" , StartUpAbout: self.startUp_About ?? "About", AppoimentStatus: self.startUp_Appoimentstatus ?? "appoimentstatus" , AppoimentTime: self.startUp_AppoimentTime ?? "AppoimentTime", ContectInforamtion: startUp_ContectInforamtion ?? contect))
            
            self.startUpName.text = self.startUp_Name
            self.startUpMail.text = self.startUp_Email
            self.startUpPhone.text = self.startUp_Phone
            self.startUpLinkedIn.text = self.startUp_Linkedin
            self.aboutStartUp.text  = self.startUp_About
           // self.sureMessageTxt
            self.imgUrl(imgUrl: (self.startUp_ImageURl)!)
            if self.startUp_Appoimentstatus != nil && self.startUp_Appoimentstatus != "notSent" {
                self.afterRescadualeFrame()
            } else {
                self.defaultFrame()
            }
        }
    }
    
    func popUpViewMethod()  {
        //PopUp View
        for index in 0..<availableAppointmentList.count {
            frame.origin.x = 55
            frame.origin.y = (45 * CGFloat(index)) + 75
            frame.size = CGSize(width: 200 , height: 20.0)
            
            let lblApointmet = UILabel(frame: frame)
            lblApointmet.text = availableAppointmentList[index].appoimentName
          //  lblApointmet.tag = index+1
            frameBtn.origin.x = 15
            frameBtn.origin.y = (45 * CGFloat(index)) + 75
            frameBtn.size = CGSize(width: 40 , height: 20.0)
            
            var btnCheck = UIButton(frame: frameBtn)
            btnCheck.setTitle("\(index)", for: .normal)
            btnCheck.isSelected = false
            btnCheck.addTarget(self, action: #selector(butClic(_:)), for: .touchUpInside)
            btnCheck.setImage(UIImage(named: "unCheck"), for: UIControlState.normal)
            btnCheck.setImage(UIImage(named: "check-1"), for: UIControlState.selected)
            btnCheck.tag = index + 1
            
            popUpView.addSubview(lblApointmet)
            popUpView.addSubview(btnCheck)
        }
    }
    

func imgUrl(imgUrl:String)  {
    if let imagUrlAl = imgUrl as? String {
        Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
            print(response)
            if let image = response.result.value {
                DispatchQueue.main.async{
                    self.startUpLogo.image = image
                }
            }
        })
    }
}


    
    @objc func tapLinkedInFunc(sender:UIGestureRecognizer) {
        if let openURL = URL(string: "linkedin://"){
            let canOpen = UIApplication.shared.canOpenURL(openURL)
            print("\(canOpen)")
        }
        let apppName = "linkedin"
        let appScheme = "\(apppName)://"
        let appSchemeUrl = URL(string: appScheme)
        
        if UIApplication.shared.canOpenURL(appSchemeUrl! as URL) {
            UIApplication.shared.open(appSchemeUrl!, options: [:], completionHandler: nil)
        }
        else {
            let alert = UIAlertController(title: "\(apppName) Error...", message: "the app named \(apppName) not found,please install it fia app store.", preferredStyle: .alert )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func tapMailFunc(sender:UIGestureRecognizer) {
        guard MFMailComposeViewController.canSendMail()
            else {
                return
        }
        let compser = MFMailComposeViewController()
        compser.mailComposeDelegate = self
        compser.setToRecipients([(startUp_Email)!])
        compser.setSubject("Event User Want to connect")
        compser.setMessageBody("i love your session ana want to connect with you in other deal", isHTML: false)
        present(compser, animated: true, completion: nil)
        
    }
    
    @objc func tapCallFunc(sender:UIGestureRecognizer) {
        PhoneCall.makeCall(PhoneNumber: (self.startUp_Phone)!)
    }
    
   /* @objc func tapOpenLinkFunc(sender:UIGestureRecognizer) {
        guard let url = URL(string: (singleItem?.website)!)
            else {
                return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        
    } */
    
    
    func defaultFrame() {
        rescadualeView.isHidden = true
        informationTopConstraint.constant = -46
    }
    
    func afterRescadualeFrame() {
     
        popUpContainerView.isHidden = true
        rescadualeView.isHidden = false
        informationTopConstraint.constant = 65
    }
    @IBAction func cancelAppointment(_ sender: Any) {
        defaultFrame()
       
        btnRightBar()
    }
    
    @IBAction func rescadualeAppointment(_ sender: Any) {
        popUpContainerView.isHidden = false
        btnRightBar()
    }
    
    @objc func butClic (_ sender: UIButton){
        for ind in 2..<popUpView.subviews.count {
            if ind % 2 == 1 {
                print(ind)
                print(popUpView.subviews[ind])
                (popUpView.subviews[ind] as! UIButton).isSelected = false
            } else {
                continue
            }
        }
        sender.isSelected = true
        let  buTitle = "\((sender.currentTitle)!)"
        let buTitleInt = sender.tag - 1
        //appointmentSelect = appointmentBooking[buTitleInt]
        appointmentSelect = availableAppointmentList[buTitleInt].appoimentID
        appointmentSelect_Name = availableAppointmentList[buTitleInt].appoimentName
        print(appointmentSelect)
    }
    
  /*  @objc func buLblClick (_ sender: UIGestureRecognizer){
     guard let tag = (sender.view as? UIView)?.tag else { return } // simple soluation

        let butSelec:UIButton?
        for ind in 2..<popUpView.subviews.count {
            if ind % 2 == 1 {
                print(ind)
                print(popUpView.subviews[ind])
        //        butSelec = popUpView.subviews[ind] as! UIButton
          //      butSelec?.isSelected = false
                (popUpView.subviews[ind] as! UIButton).isSelected = false
            } else {
                continue
            }
        }
       //(sender as UILabel).isSelected = true
        //butSelec.isSelected = true
    //    let  buTitle = "\((sender.text)!)"
     //   let buTitleInt = sender.tag - 1
        //appointmentSelect = appointmentBooking[buTitleInt]
        appointmentSelect = availableAppointmentList[buTitleInt].appoimentID
        appointmentSelect_Name = availableAppointmentList[buTitleInt].appoimentName

        print(appointmentSelect)
    }
    */
    func btnRightBar()  {
        let btnAppointment = UIButton(type: UIButton.ButtonType.system)
        btnAppointment.setImage(UIImage(named: "appointment"), for: UIControl.State())
        btnAppointment.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnAppointment.addTarget(self, action: #selector(popUpTool), for: UIControl.Event.touchUpInside)
        btnAppointment.tintColor = UIColor.white
        let customBarItem = UIBarButtonItem(customView: btnAppointment)
        self.navigationItem.rightBarButtonItem = customBarItem;
    }
    
    @objc func popUpTool() {
        popUpContainerView.isHidden = false
        btnRightBar()
    }
    
    
    @IBAction func savePopUpData(_ sender: Any) {
        
       afterRescadualeFrame()
        let btnSearch = UIButton(type: UIButton.ButtonType.system)
        let customBarItem = UIBarButtonItem(customView: btnSearch)
        self.navigationItem.rightBarButtonItem = customBarItem
        sureMessageTxt.text = "You send an appointment in \((self.appointmentSelect_Name)!)!"
        requestAppointment(StartupID: (singleItem?.startup_id)!, AppoimentID: (appointmentSelect)!)

    }
    
    func requestAppointment(StartupID:String,AppoimentID:String)  {
        let appointmentCheckParam : Parameters = ["startupID" : "\(StartupID)",
            "appoimentID" : "\(AppoimentID)"]
            Service.postServiceWithAuth(url: URLs.requestAppoiment, parameters: appointmentCheckParam) {
                (response) in
                print(response)
        }

    }
    
    @IBAction func buDismissPopUp(_ sender: Any) {
        popUpContainerView.isHidden = true

    }
}

extension StartupDetailsVC : MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            //show error alert
            controller.dismiss(animated: true, completion: nil)
        }
        switch  result {
        case .cancelled:
            print("cancelled")
        case .failed:
            print("failed")
        case .saved:
            print("saved")
        case .sent:
            print("sent")
            
        }
        controller.dismiss(animated: true, completion: nil)
        
    }
}

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

class StartupDetailsVC: UIViewController ,UITextViewDelegate{
    @IBOutlet weak var sendQuestionSmallContainer: UIView!
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
    @IBOutlet weak var questionText: UITextView!
    
    @IBOutlet weak var sendQuestionMainContainer: UIView!
    
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
        // pending and accept
       // if  singleItem?.appoimentStatus != nil && singleItem?.appoimentStatus != "notSent" {
        sendQuestionMainContainer.isHidden = true

        if  singleItem?.appoimentStatus == "pending" || singleItem?.appoimentStatus == "accepted" {
            afterRescadualeFrame()
            
        } else {
            defaultFrame()

        }
        if singleItem?.startupImageUrl == nil || singleItem?.startupImageUrl == "" {
            
        } else {
            Helper.loadImagesKingFisher(imgUrl: (singleItem?.startupImageUrl)!, ImgView: startUpLogo)
        }
        self.questionText.delegate = self
        self.questionText.layer.borderWidth = 1.0
        questionText.layer.borderColor = UIColor.red.cgColor
        startUpName.text = singleItem?.startupName
        startUp_Phone = singleItem?.contectInforamtion!["phone"] as! String
        startUpPhone.text = startUp_Phone
        startUp_Linkedin = singleItem?.contectInforamtion!["linkedin"] as! String
        startUpLinkedIn.text = startUp_Linkedin
        startUp_Email = singleItem?.contectInforamtion!["Email"] as! String
        startUpMail.text = startUp_Email

        if singleItem?.about == nil || singleItem?.about?.trimmed == "" {
            aboutView.isHidden = true

        } else {
            aboutView.isHidden = false
            aboutStartUp.text = singleItem?.about?.htmlToString

        }
        
      //  defaultFrame()
        
        
       // loadSessionData(StartUpID: (singleItem?.startup_id)!)
        loadavailableAppointment(StartUpID: (singleItem?.startup_id)!)
        
        if StartupDetailsVC.sechadualeBTNSend == true {
          // if  availableAppointmentList.count != 0 {
            //popUpContainerView.isHidden = false
            sendQuestionMainContainer.isHidden = false
         /*  } else {
            let alert = UIAlertController(title: "Error!", message: "There's no Available Appointments", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            } */
            
        } else
        {
            sendQuestionMainContainer.isHidden = true

             //popUpContainerView.isHidden = true
        }
        popUpContainerView.isHidden = true

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
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RegisterationVC.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
      

    }
    
    //MARK:- DismmKeyBoard
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    
    
    func hideKyebad() {
        questionText.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.sendQuestionSmallContainer.endEditing(true)
        sendQuestionSmallContainer.frame.origin.y = 0
        
    }
    
    @objc func keyboardWillChange(notification: Notification){
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if  notification.name == Notification.Name.UIKeyboardWillShow ||
            notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            // view.frame.origin.y = -150
            sendQuestionMainContainer.frame.origin.y = -150
            
        } else {
            sendQuestionMainContainer.frame.origin.y = 0
        }
        print("Keyboard will show \(notification.name.rawValue)")
        //  view.frame.origin.y = -150
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer)  {
        sendQuestionMainContainer.endEditing(true)
    }
    
    
   
    @objc func tapLinkedInFunc(sender:UIGestureRecognizer) {
        guard let url = URL(string: (self.startUp_Linkedin)!)
            else {
                return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
     /*   if let openURL = URL(string: "linkedin://"){
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
        } */
    }
    
    @objc func tapMailFunc(sender:UIGestureRecognizer) {
        guard MFMailComposeViewController.canSendMail()
            else {
                return
        }
        let compser = MFMailComposeViewController()
        compser.mailComposeDelegate = self
        compser.setToRecipients([(startUp_Email)!])
        compser.setSubject("")
        compser.setMessageBody("", isHTML: false)
        present(compser, animated: true, completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    @objc func tapCallFunc(sender:UIGestureRecognizer) {
        
        let phonelStr = (startUpPhone.text)!
        if phonelStr == "NA" || phonelStr == "" {
            
        }else {
            PhoneCall.makeCall(PhoneNumber: phonelStr)
        }
      //  PhoneCall.makeCall(PhoneNumber: (self.startUp_Phone)!)
    }
    
   /* @objc func tapOpenLinkFunc(sender:UIGestureRecognizer) {
        guard let url = URL(string: (singleItem?.website)!)
            else {
                return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        
    } */
    
    //MARK:- LoadSessionData
    func loadSessionData(StartUpID:String)  {
        if let  apiToken  = Helper.getApiToken() {
            
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
                
                self.startUpList.append(StartUpsData(StartupName: self.startUp_Name ?? "", StartupID: startUp_ID ?? "", StartupImageURL: self.startUp_ImageURl ?? "" , StartUpAbout: self.startUp_About ?? "", AppoimentStatus: self.startUp_Appoimentstatus ?? "" , AppoimentTime: self.startUp_AppoimentTime ?? "", ContectInforamtion: startUp_ContectInforamtion ?? contect))
                
                self.startUpName.text = self.startUp_Name
                self.startUpMail.text = self.startUp_Email
                self.startUpPhone.text = self.startUp_Phone
                self.startUpLinkedIn.text = self.startUp_Linkedin
                if self.startUp_About == nil || self.startUp_About == "" {
                    self.aboutView.isHidden = true
                    
                } else {
                    self.aboutView.isHidden = false
                    self.aboutStartUp.text  = self.startUp_About?.htmlToString
                    
                }
                // self.sureMessageTxt
                Helper.loadImagesKingFisher(imgUrl: (self.singleItem?.startupImageUrl)!, ImgView: self.startUpLogo)
                
                if self.startUp_Appoimentstatus != nil && self.startUp_Appoimentstatus != "notSent" {
                    self.afterRescadualeFrame()
                } else {
                    self.defaultFrame()
                }
            }
        } else {
            Service.getService(url: "\(URLs.getStartupDetailsByID)/\(StartUpID)") {
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
                self.aboutStartUp.text  = self.startUp_About?.htmlToString
                // self.sureMessageTxt
                Helper.loadImagesKingFisher(imgUrl: (self.startUp_ImageURl)!, ImgView: self.startUpLogo)
                
                if self.startUp_Appoimentstatus != nil && self.startUp_Appoimentstatus != "notSent" {
                    self.afterRescadualeFrame()
                } else {
                    self.defaultFrame()
                }
            }
        }
    }
    
    
   
    
    //MARK:- RadioButtonsSelection

    @objc func labelChoiseFunc(sender:UIGestureRecognizer) {//UIGestureRecognizer
        //  guard let TagRe = (sender.view as? UILabel)?.text else { return }
        guard let tag = (sender.view as? UILabel)?.tag else { return }
        
        for ind in 2..<popUpView.subviews.count {
            if ind % 2 == 1 {
                print(ind)
                print(popUpView.subviews[ind])
                (popUpView.subviews[ind] as! UIButton).isSelected = false
            } else {
                continue
            }
        }
        (popUpView.viewWithTag(tag * 2) as? UIButton)!.isSelected = true
        appointmentSelect = availableAppointmentList[tag - 1].appoimentID
        appointmentSelect_Name = availableAppointmentList[tag - 1].appoimentName
        print(appointmentSelect_Name)
        print(tag - 1)
        //  performSegue(withIdentifier: "newsdetail", sender: topNewsList[tag - 1]) //topNewsList[]
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
        let buTitleInt = (sender.tag / 2 ) - 1
        //appointmentSelect = appointmentBooking[buTitleInt]
        appointmentSelect = availableAppointmentList[buTitleInt].appoimentID
        appointmentSelect_Name = availableAppointmentList[buTitleInt].appoimentName
        print(appointmentSelect)
    }
    
    //MARK:- BarButton
    func btnRightBar()  {
        if let  apiToken  = Helper.getApiToken() {
        let btnAppointment = UIButton(type: UIButton.ButtonType.system)
        btnAppointment.setImage(UIImage(named: "appointment"), for: UIControl.State())
        btnAppointment.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnAppointment.addTarget(self, action: #selector(popUpTool), for: UIControl.Event.touchUpInside)
        btnAppointment.tintColor = UIColor.white
        let customBarItem = UIBarButtonItem(customView: btnAppointment)
        self.navigationItem.rightBarButtonItem = customBarItem;
        } else {
            
        }
    }
    
    //MARK:- SendQuestionMethods
    func sendQeusetionMethod()  {
        if let apiToken = Helper.getApiToken() {
            let questionTextSend = questionText.text
            if questionTextSend?.trimmed == "" || questionTextSend == nil {
                let alert = UIAlertController(title: "oPP's!", message: "You didn't write your question!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                let questionCheckParam : Parameters =
                    ["StartUPID": "\((self.singleItem?.startup_id)!)",
                        
                        "QuestionDescription": "\((questionTextSend)!)"]
                OpenSessionVC.likeFlag = "faveMethod"
                
                Service.postServiceWithAuth(url: URLs.askStartupExhibtorQuestion, parameters: questionCheckParam) {
                    (response) in
                    print(response)
                    if response == nil {
                        OpenSessionVC.likeFlag = ""
                        self.questionText.text = ""
                        self.sendQuestionMainContainer.isHidden = true
                        let alert = UIAlertController(title: "Succes!", message: "your question is send!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        //        self.sendQuestMainContainer.isHidden = true
                        
                    }
                }
                
            }
        } else {
            let alert = UIAlertController(title: "NotAllowed!", message: "you must sign in to do this part!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    
    }
    @IBAction func sendQuestion(_ sender: Any) {
        sendQeusetionMethod()
    }
    @IBAction func dismissQuestionContainer(_ sender: Any) {
        
        sendQuestionMainContainer.isHidden = true
        hideKyebad()

    }
    @objc func popUpTool() {
        sendQuestionMainContainer.isHidden = false

   /*     if  availableAppointmentList.count != 0 {
        popUpContainerView.isHidden = false
        } else {
            let alert = UIAlertController(title: "Error!", message: "There's no Available Appointments", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } */
        btnRightBar()
    }
    
    //MARK:- Appointment
    
    func popUpViewMethod()  {
        //PopUp View
        for index in 0..<availableAppointmentList.count {
            frame.origin.x = 55
            frame.origin.y = (45 * CGFloat(index)) + 75
            frame.size = CGSize(width: 200 , height: 20.0)
            
            let lblApointmet = UILabel(frame: frame)
            lblApointmet.text = availableAppointmentList[index].appoimentName
            lblApointmet.tag = index+1
            let titleLabelGest = UITapGestureRecognizer(target: self, action: #selector(StartupDetailsVC.labelChoiseFunc))
            lblApointmet.isUserInteractionEnabled = true
            lblApointmet.addGestureRecognizer(titleLabelGest)
            
            frameBtn.origin.x = 15
            frameBtn.origin.y = (45 * CGFloat(index)) + 75
            frameBtn.size = CGSize(width: 40 , height: 20.0)
            
            var btnCheck = UIButton(frame: frameBtn)
            btnCheck.setTitle("\(index)", for: .normal)
            btnCheck.isSelected = false
            btnCheck.addTarget(self, action: #selector(butClic(_:)), for: .touchUpInside)
            btnCheck.setImage(UIImage(named: "unCheck"), for: UIControlState.normal)
            btnCheck.setImage(UIImage(named: "check-1"), for: UIControlState.selected)
            btnCheck.tag = (index + 1) * 2
            
            popUpView.addSubview(lblApointmet)
            popUpView.addSubview(btnCheck)
        }
    }
    func defaultFrame() {
        rescadualeView.isHidden = true
        informationTopConstraint.constant = -46
    }
    
    func afterRescadualeFrame() {
        
        /*     popUpContainerView.isHidden = true
         rescadualeView.isHidden = false
         informationTopConstraint.constant = 65 */
        
    }
    @IBAction func cancelAppointment(_ sender: Any) {
        /*   UIView.animate(withDuration: 0.9, animations: { () -> Void in
         //   self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
         //self.view.layoutIfNeeded()
         //  self.view.backgroundColor = UIColor.clear
         self.defaultFrame()
         self.btnRightBar()
         
         }, completion: { (finished) -> Void in
         // self.view.removeFromSuperview()
         // self.removeFromParentViewController()
         }) */
        defaultFrame()
        btnRightBar()
    }
    
    @IBAction func rescadualeAppointment(_ sender: Any) {
        availableAppointmentList.removeAll()
        loadavailableAppointment(StartUpID: (singleItem?.startup_id)!)
        
        //some issue think loading
        if  availableAppointmentList.count != 0 {
            popUpContainerView.isHidden = false
        } else {
            let alert = UIAlertController(title: "Error!", message: "There's no Available Appointments", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        btnRightBar()
    }
    @IBAction func savePopUpData(_ sender: Any) {
      
        if self.appointmentSelect_Name != nil {
         afterRescadualeFrame()
        let btnSearch = UIButton(type: UIButton.ButtonType.system)
        let customBarItem = UIBarButtonItem(customView: btnSearch)
        self.navigationItem.rightBarButtonItem = customBarItem
            sureMessageTxt.text = "You send an appointment in \((self.appointmentSelect_Name)!)!"
            requestAppointment(StartupID: (singleItem?.startup_id)!, AppoimentID: (appointmentSelect)!)

        }

    }
    
    func requestAppointment(StartupID:String,AppoimentID:String)  {
        OpenSessionVC.likeFlag = "faveMethod"  //
        let appointmentCheckParam : Parameters = ["startupID" : "\(StartupID)",
            "appoimentID" : "\(AppoimentID)"]
            Service.postServiceWithAuth(url: URLs.requestAppoiment, parameters: appointmentCheckParam) {
                (response) in
                print(response)
                if response == nil {
                    OpenSessionVC.likeFlag = ""  //

                }

        }

    }
    func loadavailableAppointment(StartUpID:String)  {
        if let  apiToken  = Helper.getApiToken() {
            
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
        } else {
            
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

//
//  SigninVC.swift
//  Elshams
//
//  Created by mac on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import  MaterialComponents.MaterialTextFields
//import  MaterialComponents.MDCTextInputControllerFilled

class SigninVC: UIViewController ,  UITextFieldDelegate { 
    @IBOutlet weak var signInView: UIView!
    
    @IBOutlet weak var signInScrollView: UIScrollView!
  
    @IBOutlet weak var userNameInputlTxt: MDCTextField!
    var textFieldControllerFloating = MDCTextInputControllerUnderline()

    
  //  @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userNameError: UILabel!
    
    @IBOutlet weak var userProfileImg: UIImageView!
  //  @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var passwordInputTxt: MDCTextField!
    //@IBOutlet weak var passwordInputTxt: UITextField!

    @IBOutlet weak var passwordError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //speaker static list
        
        SpeakersVC.speakerList.removeAll()
        SpeakersVC.speakerList.append(Speakers(SpeakerName: "Khaled bakar", JobTitle: "Programmer", jobDescribition: "IOSDeveloper", SpImage: "profile1", FacebookInLink: "facebook.com/khaledbakar.12", Phone: "01060136503", Mail: "kzaky@ikdynamics.com", About: "one of the most importanat people in the life he hasn't title job his name is a title", Website: "www.khaledbakar.com", ActiveOrNot: true, Speaker_id: 0, Speaker_id_Str: "0"))
        SpeakersVC.speakerList.append(Speakers(SpeakerName: "Khaled bakar", JobTitle: "Programmer", jobDescribition: "IOSDeveloper", SpImage: "profile2", FacebookInLink: "facebook.com/khaledbakar.12", Phone: "01060136503", Mail: "kzaky@ikdynamics.com", About: "one of the most importanat people in the life he hasn't title job his name is a title", Website: "www.google.com", ActiveOrNot: true, Speaker_id: 1, Speaker_id_Str: "1"))
        SpeakersVC.speakerList.append(Speakers(SpeakerName: "saad hamo", JobTitle: "Programmer", jobDescribition: "IOSDeveloper", SpImage: "avatar", FacebookInLink: "facebook.com/khaledbakar.12", Phone: "01060136503", Mail: "kzaky@ikdynamics.com", About: "one of the most importanat people in the life he hasn't title job his name is a title", Website: "https://www.facebook.com", ActiveOrNot: false, Speaker_id: 2, Speaker_id_Str: "2"))
        
        //startup static list
        //3shan bttkrr 3ayz 7l
        StartUps.startUpList.removeAll()
        
        StartUps.startUpList.append(StartUpsData(StartupName: "El7ag Bakar", StartupAddress: "1 Tahrir Square,cairo,Egypt", StartupImage: "profile1", StartUpLinkedIn: "khaled.zaki12", StartUpPhone: "01060136503", StartUpMail: "kzakyy@ikdynamics.com", StartUpAbout: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, ", AcceptedApointment: true, PendingApointment: false, AcceptedApointmentStr: "true", PendingApointmentStr: "false", Id_StartUp: 0))
        
        StartUps.startUpList.append(StartUpsData(StartupName: "MedGram", StartupAddress: "18A Obour Bulidings,cairo,Egypt", StartupImage: "avatar", StartUpLinkedIn: "khaled.zaki12", StartUpPhone: "01060136503", StartUpMail: "kzakyy@ikdynamics.com", StartUpAbout: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, ", AcceptedApointment: false, PendingApointment: true, AcceptedApointmentStr: "false", PendingApointmentStr: "true", Id_StartUp: 1))
        StartUps.startUpList.append(StartUpsData(StartupName: "MedGram", StartupAddress: "18A Obour Bulidings,cairo,Egypt", StartupImage: "avatar", StartUpLinkedIn: "khaled.zaki12", StartUpPhone: "01060136503", StartUpMail: "kzakyy@ikdynamics.com", StartUpAbout: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, ", AcceptedApointment: false, PendingApointment: true, AcceptedApointmentStr: "false", PendingApointmentStr: "true", Id_StartUp: 2))
        
        StartUps.startUpList.append(StartUpsData(StartupName: "MedGram", StartupAddress: "18A Obour Bulidings,cairo,Egypt", StartupImage: "avatar", StartUpLinkedIn: "khaled.zaki12", StartUpPhone: "01060136503", StartUpMail: "kzakyy@ikdynamics.com", StartUpAbout: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, ", AcceptedApointment: false, PendingApointment: false, AcceptedApointmentStr: "false", PendingApointmentStr: "false", Id_StartUp: 3))
        StartUps.startUpList.append(StartUpsData(StartupName: "El7ag Bakar", StartupAddress: "1 Tahrir Square,cairo,Egypt", StartupImage: "profile1", StartUpLinkedIn: "khaled.zaki12", StartUpPhone: "01060136503", StartUpMail: "kzakyy@ikdynamics.com", StartUpAbout: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, ", AcceptedApointment: true, PendingApointment: false, AcceptedApointmentStr: "true", PendingApointmentStr: "false", Id_StartUp: 4))

        //agendaa
        
        AgendaVC.agendaList.removeAll()
        AgendaVC.agendaList.append(ProgramAgendaItems(ProgramName: "Regestration and Networking", StartTime: "8AM", EndTime: "10AM", ProgLocation: "hall", SpImageOne: "avatar", SpImageTwo: "avatar",AgendaDate:"Monday,March 8", FavouriteSession: true, FavouriteSessionStr: "true", Describtion: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore ", Speaker_FK_Id: 2, Speaker_FK_Id_Str: "2"))
        AgendaVC.agendaList.append(ProgramAgendaItems(ProgramName: "Ministers from the Cambinet Economic Group and selected", StartTime: "11AM", EndTime: "11.30AM", ProgLocation: "cinema", SpImageOne: "avatar", SpImageTwo: "avatar",AgendaDate:"Monday,March 8", FavouriteSession: false, FavouriteSessionStr: "false", Describtion: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore ", Speaker_FK_Id: 1, Speaker_FK_Id_Str: "1"))
        AgendaVC.agendaList.append(ProgramAgendaItems(ProgramName: "New Reg", StartTime: "11AM", EndTime: "11.30AM", ProgLocation: "cinema", SpImageOne: "avatar", SpImageTwo: "avatar",AgendaDate:"Monday,March 9", FavouriteSession: true, FavouriteSessionStr: "true", Describtion: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore ", Speaker_FK_Id: 1, Speaker_FK_Id_Str: "1"))

        
       // userNameInputlTxt = MDCTextField()
        userNameInputlTxt.placeholder = "Name"
        userNameInputlTxt.isEnabled = true
        userNameInputlTxt.isUserInteractionEnabled = true
        userNameInputlTxt.clearButtonMode = .whileEditing
     //   userNameInputlTxt.tintColor = UIColor.white
      //  userNameInputlTxt.textColor = UIColor.lightGray
   //     userNameInputlTxt.cursorColor = UIColor.darkGray

      //  userNameInputlTxt.keyboardAppearance =
        
        textFieldControllerFloating = MDCTextInputControllerUnderline(textInput: userNameInputlTxt)
      //  textFieldControllerFloating.helperText = "Enter a name"
        textFieldControllerFloating.leadingUnderlineLabelTextColor = UIColor.darkGray       // The helper text
        textFieldControllerFloating.trailingUnderlineLabelTextColor = UIColor.green
        textFieldControllerFloating.inlinePlaceholderColor = UIColor.white
      //  textFieldControllerFloating.textco = UIColor.white              // inline label
// inline label
       // textFieldControllerFloating.borderFillColor = UIColor.white
        textFieldControllerFloating.isFloatingEnabled = true
        
        textFieldControllerFloating.activeColor = UIColor.lightGray               // active label & underline
        textFieldControllerFloating.floatingPlaceholderActiveColor = UIColor.white
        textFieldControllerFloating.normalColor = UIColor.white                         // default underline
        textFieldControllerFloating.errorColor = UIColor.red
        
      //  textFieldControllerFloating.floatingPlaceholderNormalColor = UIColor.white
      //  textFieldControllerFloating.leadingico
      //  userNameInputlTxt.textColor = UIColor.white
        userNameInputlTxt.textColor = UIColor.white
       // userNameInputlTxt.tou
        //userNameInputlTxt.keyboardAppearance =
        MdcText.mdcTextField(textFInput: passwordInputTxt, Placeholder: "PASSWORD")
        passwordInputTxt.textColor = UIColor.white
        
        userProfileImg.layer.cornerRadius = userProfileImg.frame.width / 2
        userProfileImg.clipsToBounds = true
        userNameError.isHidden = true
        passwordError.isHidden = true 
      //  userNameLbl.isHidden = true
     //   passwordLbl.isHidden = true
       // let textFieldFloating = MDCMultilineTextField()
        
       // scrollView.addSubview(textFieldFloating)
        
      // let textFieldControllerFloating = MDCTextInputControllerUnderline(textInput: textFieldFloating)
      //  textFieldControllerFloating.i
        userNameInputlTxt.delegate = self
        passwordInputTxt.delegate = self


        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RegisterationVC.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer)  {
        if userNameInputlTxt.text == "" {
           // userNameLbl.isHidden = true
        }
        if passwordInputTxt.text == "" {
           // passwordLbl.isHidden = true
        }
        view.endEditing(true)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.signInView.endEditing(true)
        self.signInScrollView.endEditing(true)
        
        if userNameInputlTxt.text == "" {
           // userNameLbl.isHidden = true
        }
        if passwordInputTxt.text == "" {
           // passwordLbl.isHidden = true
        }
        view.frame.origin.y = 0
    }
    
    func hideKyebad() {
        passwordInputTxt.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        passwordError.isHidden = true
        userNameError.isHidden = true
      //  userNameLbl.isHidden = true
     //   passwordLbl.isHidden = true
    }
    
    @objc func keyboardWillChange(notification: Notification){
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if  notification.name == Notification.Name.UIKeyboardWillShow ||
            notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0
        }
        print("Keyboard will show \(notification.name.rawValue)")
        //   view.frame.origin.y = -150
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        passwordError.isHidden = true
        userNameError.isHidden = true
        if textField.isEqual(userNameInputlTxt) {
          //  userNameLbl.isHidden = false
            if passwordInputTxt.text == "" {
              //  passwordLbl.isHidden = true
            }
        }
        else if textField.isEqual(passwordInputTxt) {
           // passwordLbl.isHidden = false
            if userNameInputlTxt.text == "" {
           //     userNameLbl.isHidden = true
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // self.view.endEditing(true)
        hideKyebad()
        signInMethod()

        return true
    }
    
    
    
    func signInMethod() {
        let username = userNameInputlTxt.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = passwordInputTxt.text
       /* if (username == UserAccount.first?.username  && pass == UserAccount.first?.password )
        {
            userNameFk = username
            SigninVC.fkUserName = username!
            userFkNa = ["userAcc" : "\(username!)"]
            userDefaults.set(userFkNa, forKey: "fkuseradmin")
            performSegue(withIdentifier: "signin", sender: nil)
            userDefaults.set(false, forKey: "userLoggedin")
            
            userNameInputlTxt.text = ""
            passwordInputTxt.text = ""
        }  else */
         if (username == "admin" && pass == "admin") {
           // userNameFk = username
          //  SigninVC.fkUserName = username!
         //   userFkNa = ["userAcc" : "admin" ]
           // userDefaults.set(userFkNa, forKey: "fkuseradmin")
           // userDefaults.set(false, forKey: "userLoggedin")
            performSegue(withIdentifier: "skipnav", sender: nil)
            
            userNameInputlTxt.text = ""
            passwordInputTxt.text = ""
        }
    /*    else if (username == UserAccount.first?.username  && pass != UserAccount.first?.password )
        {
            lblError.isHidden = false
            lblError.text = "Wrong password!"
            
        }
        else if (username != UserAccount.first?.username  && pass == UserAccount.first?.password ) //mlosh lazma 8albn w msh mntky
        {
            lblError.isHidden = false
            lblError.text = "Wrong Username!"
            
        } */
        else {
            userNameError.isHidden = false
            passwordError.isHidden = false
            userNameError.text = "Wrong Username !"
            passwordError.text = "Wrong Username !"
        }
      //  hideKyebad()
      /*  let sourceLoc = locationManger.location?.coordinate
        SigninVC.myLocLatit = (sourceLoc?.latitude)!
        SigninVC.myLocLang = (sourceLoc?.longitude)! */
        
    }
    
    @IBAction func skipLogin(_ sender: Any) {
        performSegue(withIdentifier: "skipnav", sender: nil)
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
    }
    
    @IBAction func logIn(_ sender: Any) {
    signInMethod()
    }
    
}

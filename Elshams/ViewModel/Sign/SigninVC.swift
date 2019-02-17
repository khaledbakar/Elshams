//
//  SigninVC.swift
//  Elshams
//
//  Created by mac on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import  MaterialComponents.MaterialTextFields
import SwiftyJSON
import Alamofire
import AlamofireImage
//import  MaterialComponents.MDCTextInputControllerFilled

class SigninVC: UIViewController ,  UITextFieldDelegate { 
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var activeLoginLoader: UIActivityIndicatorView!
    
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

        self.activeLoginLoader.isHidden = true

        NotificationCenter.default.addObserver(self, selector: #selector(loginError), name: NSNotification.Name("LoginError"), object: nil)
        //speaker static list
        
   
       // userNameInputlTxt = MDCTextField()
      
     //   userNameInputlTxt.tintColor = UIColor.white
      //  userNameInputlTxt.textColor = UIColor.lightGray
   //     userNameInputlTxt.cursorColor = UIColor.darkGray

      //  userNameInputlTxt.keyboardAppearance =
        
     /*   userNameInputlTxt.placeholder = "Name"
        userNameInputlTxt.isEnabled = true
        userNameInputlTxt.isUserInteractionEnabled = true
        userNameInputlTxt.clearButtonMode = .whileEditing
        
        textFieldControllerFloating = MDCTextInputControllerUnderline(textInput: userNameInputlTxt)
        textFieldControllerFloating.leadingUnderlineLabelTextColor = UIColor.darkGray       // The helper text
        textFieldControllerFloating.trailingUnderlineLabelTextColor = UIColor.green
        textFieldControllerFloating.inlinePlaceholderColor = UIColor.white
        
        textFieldControllerFloating.isFloatingEnabled = true
        
        textFieldControllerFloating.activeColor = UIColor.lightGray               // active label & underline
        textFieldControllerFloating.floatingPlaceholderActiveColor = UIColor.white
        textFieldControllerFloating.normalColor = UIColor.white                         // default underline
        textFieldControllerFloating.errorColor = UIColor.red
        
        MdcText.mdcTextField(textFInput: passwordInputTxt, Placeholder: "PASSWORD")
*/
        
        //  textFieldControllerFloating.helperText = "Enter a name"

      //  textFieldControllerFloating.textco = UIColor.white              // inline label
// inline label
       // textFieldControllerFloating.borderFillColor = UIColor.white
       
        
      //  textFieldControllerFloating.floatingPlaceholderNormalColor = UIColor.white
      //  textFieldControllerFloating.leadingico
      //  userNameInputlTxt.textColor = UIColor.white
        userNameInputlTxt.textColor = UIColor.black
       // userNameInputlTxt.tou
        //userNameInputlTxt.keyboardAppearance =
        passwordInputTxt.textColor = UIColor.black
        
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
    @objc func loginError(){
        // performSegue(withIdentifier: "ShowSetting", sender: nil)
      //  print("setting")
        self.activeLoginLoader.isHidden = true
        self.activeLoginLoader.stopAnimating()
        let alert = UIAlertController(title: "Error!", message: "The user name or password is incorrect.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        passwordError.text = "The user name or password is incorrect."
        passwordError.isHidden = false

        
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
          //  view.frame.origin.y = -150

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
        hideKyebad()
        guard let email = userNameInputlTxt.text, !email.isEmpty else {
            userNameError.isHidden = false
            userNameError.text = "you must enter your name"
            
            return
            
        }
        guard let password = passwordInputTxt.text, !password.isEmpty else {
            passwordError.isHidden = false
            passwordError.text = "you must enter your password"


            return
            
        }
        self.activeLoginLoader.isHidden = false
        self.activeLoginLoader.startAnimating()
        let username = userNameInputlTxt.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = passwordInputTxt.text
        API.login(Email: email, Password: password) { (error: Error?,succes:Bool) in
            if succes {
                print("Succes")
          //      self.loadUserData()
                self.performSegue(withIdentifier: "skipnav", sender: nil) // SuccesLogin
              //  NotificationCenter.default.post(name: NSNotification.Name("SuccesLogin"), object: nil)

                self.activeLoginLoader.isHidden = true
                self.activeLoginLoader.stopAnimating()

            }
            else {
            }
        }
        /* if (username == "admin" && pass == "admin") {
            performSegue(withIdentifier: "skipnav", sender: nil)
            userNameInputlTxt.text = ""
            passwordInputTxt.text = ""
        } */
    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    
    @IBAction func skipLogin(_ sender: Any) {
        let def = UserDefaults.standard
        def.setValue(nil, forKey: "api_token")
        def.synchronize()
        hideKyebad()
        performSegue(withIdentifier: "skipnav", sender: nil)
    }
    func  loadUserData()  {
        if let  apiToken  = Helper.getApiToken() {
            Service.getServiceWithAuth(url: URLs.getSettingData){
                (response) in
                print(response)
                let result = JSON(response)
                let user_Name = result["Title"].string
                let user_JobTitle = result["jobTitle"].string
                let user_CompanyName = result["companyName"].string
                var user_ImageUrl = result["picture"].string
                let user_Password = result["password"].string
                let user_Email = result["email"].string
                let user_Linkedin = result["linkedin"].string
                let user_Phone = result["phone"].string
                let user_about = result["about"].string
                let user_Ispublic_str = result["isPublic"].string
                // self.imgUserUrl = user_ImageUrl
                // internet error handel
                if user_Name == nil ||  user_Name == "" {
                    Helper.saveUserName(UserName: user_Name!)
                }
                if user_ImageUrl != nil {
                    self.imgUrl(imgUrl: (user_ImageUrl)!)
                }
            }
        }
    }
    func imgUrl(imgUrl:String)  {
        // if  TimeLineHomeVC.failMessage !=  "fail"{
        if let imagUrlAl = imgUrl as? String {
            Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                print(response)
                switch response.result {
                case .success(let value):
                    if let image = response.result.value {
                        DispatchQueue.main.async{
                        //    if let apiToken = json["access_token"].string {
                        //        print("api token \(apiToken)")
                                Helper.saveUserImage(UserProfile: image)
                                //      completion(nil , true)
                         //   }
                         //   self.userProfile.image = image
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                    
                }
            })
        }
        // }
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
    }
    
    @IBAction func logIn(_ sender: Any) {
    signInMethod()
    }
    
}

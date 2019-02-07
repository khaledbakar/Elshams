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
    @objc func loginError(){
        // performSegue(withIdentifier: "ShowSetting", sender: nil)
      //  print("setting")
        self.activeLoginLoader.isHidden = true
        self.activeLoginLoader.stopAnimating()

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

                self.performSegue(withIdentifier: "skipnav", sender: nil)
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
    
    @IBAction func skipLogin(_ sender: Any) {
        let def = UserDefaults.standard
        def.setValue(nil, forKey: "api_token")
        def.synchronize()
        performSegue(withIdentifier: "skipnav", sender: nil)
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
    }
    
    @IBAction func logIn(_ sender: Any) {
    signInMethod()
    }
    
}

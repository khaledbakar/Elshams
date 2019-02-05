//
//  RegisterationVC.swift
//  Elshams
//
//  Created by mac on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class RegisterationVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate  {
    

    @IBOutlet weak var emaiInputlTxt: UITextField!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailError: UILabel!
    
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var passwordInputTxt: UITextField!
    @IBOutlet weak var passwordError: UILabel!
    
    @IBOutlet weak var jobTitleInput: UITextField!
    @IBOutlet weak var jobTitleError: UILabel!
    @IBOutlet weak var jobTitleLbl: UILabel!
    
    @IBOutlet weak var phoneInputTxt: UITextField!
    @IBOutlet weak var phoneError: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    
    @IBOutlet weak var othersError: UILabel!
    @IBOutlet weak var othersLbl: UILabel!
    @IBOutlet weak var othersInputTxt: UITextField!
    
    var imagePicker: UIImagePickerController!
    @IBOutlet weak var profileImage: UIImageView!
    var imageProfileB64 : String?
    
  //  var validnumber:Bool?
    var validPassword:Bool?
    var validEmail:Bool?
    
   // var userTriming:String?
    var passwordTriming:String?
    var emailTrim:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.clipsToBounds = true
        emailError.isHidden = true
        passwordError.isHidden = true
        phoneError.isHidden = true
        othersError.isHidden = true
        jobTitleError.isHidden = true
        
     //   imagePicker = UIImagePickerController()
       // imagePicker.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RegisterationVC.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)

    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    
   
    func hideKyebad() {
        passwordInputTxt.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        view.frame.origin.y = 0
        
    }
    
    @objc func keyboardWillChange(notification: Notification){
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if  notification.name == Notification.Name.UIKeyboardWillShow ||
            notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            view.frame.origin.y = -100
        } else {
            view.frame.origin.y = 0
        }
        print("Keyboard will show \(notification.name.rawValue)")
        //  view.frame.origin.y = -150
    }
    
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isEqual(emaiInputlTxt){
            emailError.isHidden = true
            emailLbl.isHidden = false
        }
        else if textField.isEqual(passwordInputTxt){
            passwordError.isHidden = true
            passwordLbl.isHidden = false
        }
      /*  else if textField.isEqual(lblEmail){
            lblEmailError.isHidden = true
            lblShowEmail.isHidden = false
        } */
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //Email Validation
        if textField.isEqual(emaiInputlTxt){
            guard let email = emaiInputlTxt.text, emaiInputlTxt.text?.characters.count != 0  else {
                emailError.isHidden = false
                emailError.text = "Please enter your email"
                validEmail = false
                return false
            }
            
            if isValidEmail(emailID: email) == false {
                emailError.isHidden = false
                emailError.text = "Please enter valid email address"
                validEmail = false
                
            } else {
                emailTrim = email
                validEmail = true
                emailError.isHidden = true
            }
        }
            /*
            //UserName Validation
        else if textField.isEqual(lblUserName) {
            userTriming = lblUserName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            if userTriming != "" && userTriming != nil && userTriming != "null" && userTriming?.characters.count != 0  {
                loadUserName(UserNameDouble: userTriming!)
                if(userTriming == UserAccountDouble.first?.username){
                    lblUserError.text = "Already have this account!"
                    lblUserError.isHidden = false
                    validUserName = false
                }
                else if (userTriming?.characters.count)! > 50 {
                    lblUserError.text = "Long UserName!"
                    lblUserError.isHidden = false
                    validUserName = false
                }
                else {
                    lblUserError.isHidden = true
                    validUserName = true
                }
            }
 
                //Password Validation
            else {
                lblUserError.text = "please enter your name"
                lblShowFullName.isHidden = true
                lblUserError.isHidden = false
                validUserName = false
            }
        }*/
        else if textField.isEqual(passwordInputTxt){
            passwordTriming = passwordInputTxt.text
            if passwordTriming?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && passwordTriming != nil && passwordTriming != "null" && (passwordTriming?.characters.count)! != 0 && (passwordTriming?.characters.count)! >= 6 {
                validPassword = true
            } else if (passwordTriming?.characters.count)! < 6 {
                passwordError.text = "password at least 6!"
                passwordError.isHidden = false
                passwordError.isHidden = true
                validPassword = false
            }
            else {
                passwordError.text = "please enter your password!"
                passwordError.isHidden = false
               // lblShowPassword.isHidden = true
                validPassword = false
                //Darsh Abo Nassar
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKyebad()
        self.view.endEditing(true)
        return true
    }
    
   
    @IBAction func imageSelect(_ sender: Any) {
        present(imagePicker,animated: true , completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            profileImage.image = image
            let jpegCompressionQuality: CGFloat = 0.3 // Set this to whatever suits your purpose
            if let base64String = UIImageJPEGRepresentation(image, jpegCompressionQuality)?.base64EncodedString() {
                // Upload base64String to your database
                imageProfileB64 = base64String
              //  print(base64String)
            }
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer)  {
        view.endEditing(true)
    }

    func registertionMethod()  {
        /*
        let paramRegisteration : [String:Any] = [
           "Email" : "\((emaiInputlTxt.text)!)",
            "password" : "\((passwordInputTxt.text)!)",
            "Title" : "\((othersInputTxt.text)!)", //title name and about and company name no field for it
            "CompanyName" : "\((othersInputTxt.text)!)",
            "jobTitle" : "\((jobTitleInput.text)!)",
            "about" : "ios deveopler and photographer",
            "phone" : "\((phoneInputTxt.text)!)",
            "picture" : "",
            "linkedin" : "linkedin.com"
             /*"Email" : "khale16@yahoo.com",
            "password" : "12345678",
            "Title" : "khark",
            "CompanyName" : "ikd",
            "jobTitle" : "devleoper",
            "about" : "ios deveopler and photographer",
            "phone" : "01060136503",
            //"picture" : "\(picBase64)",
            "picture" : "",
            "linkedin" : "linkedin.com" */
        ] */
       // if validEmail == true && validPassword == true {
        
          /*  Service.postService(url: URLs.register, parameters: paramRegisteration){ (response) in
                print("This is response request : ")
                print(response)
            } */
       // }
    }
    @IBAction func register(_ sender: Any) {
        guard let email = emaiInputlTxt.text?.trimmed, !email.isEmpty, let password = passwordInputTxt.text, !password.isEmpty, let jobTiltle = jobTitleInput.text?.trimmed , !jobTiltle.isEmpty, let phoneNum = phoneInputTxt.text?.trimmed , !phoneNum.isEmpty , let other = othersInputTxt.text?.trimmed , !other.isEmpty else { return }
        if TimeLineHomeVC.failMessage !=  "fail" {
            API.register(Email: email.lowercased(), Password: password, Title: other , CompanyName: jobTiltle, JobTitle: jobTiltle, About: jobTiltle, Phone: phoneNum, Picture: imageProfileB64 ?? "", Linkedin: "") { (error: Error?,succes:Bool) in
            if succes {
                print("Succes")
              //  let alert = UIAlertController(title: "Succes!", message: "Your data is Updated!", preferredStyle: UIAlertControllerStyle.alert)
             //   alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            //    self.present(alert, animated: true, completion: nil)
            }
        }
            
        } else {
            
        }
    //registertionMethod(picBase64: pic64)
    }
    
 
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
}

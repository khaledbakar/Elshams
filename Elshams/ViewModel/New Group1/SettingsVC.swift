//
//  SettingsVC.swift
//  Elshams
//
//  Created by mac on 12/23/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
//import AlamofireImage
import Alamofire
import SwiftyJSON

class SettingsVC: UIViewController  , UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate{

    var settingList = Array<UserData>()
    var statSettingList : [String]?
    var cellSettingList : [String]?
    var imageProfileB64 : String = ""
    static var udapatedMessage = ""
    var validPassword:Bool = true
    var validEmail:Bool = true
    var imagePicker: UIImagePickerController!
    
    var passwordTriming:String?
    var emailTrim:String?
    

    @IBOutlet weak var emaiInputlTxt: UITextField!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailError: UILabel!
    
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var passwordInputTxt: UITextField!
    @IBOutlet weak var passwordError: UILabel!
    
    
    @IBOutlet weak var confirmPasswordLbl: UILabel!
    @IBOutlet weak var confirmPasswordInputTxt: UITextField!
    @IBOutlet weak var confirmPasswordError: UILabel!
    
    @IBOutlet weak var jobTitleInput: UITextField!
    @IBOutlet weak var jobTitleError: UILabel!
    @IBOutlet weak var jobTitleLbl: UILabel!
    
    @IBOutlet weak var phoneInputTxt: UITextField!
    @IBOutlet weak var phoneError: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    
    @IBOutlet weak var othersError: UILabel!
    @IBOutlet weak var othersLbl: UILabel!
    @IBOutlet weak var othersInputTxt: UITextField!
    
    @IBOutlet weak var companyNameError: UILabel!
    @IBOutlet weak var companyNameLbl: UILabel!
    @IBOutlet weak var companyNameInputTxt: UITextField!
    
    @IBOutlet weak var linkedInError: UILabel!
    @IBOutlet weak var linkedInLbl: UILabel!
    @IBOutlet weak var linkedInInputTxt: UITextField!
    
    @IBOutlet weak var titleError: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var titleInputTxt: UITextField!
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageProfileB64 = ""
        profileImg.layer.cornerRadius = profileImg.frame.width / 2
        profileImg.clipsToBounds = true
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        firstHideErrors()
        textFieldsDelegats()
        activityLoader.isHidden = true

        if let  apiToken  = Helper.getApiToken() {
            profileImg.isHidden = false
            updateBtn.isHidden = false
            loadSettingData()
        
        }else{
            //view.isHidden = true
            profileImg.isHidden = true
            updateBtn.isHidden = true
            let alert = UIAlertController(title: "Error", message: "You must sign in to Show this Part", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
         NotificationCenter.default.addObserver(self, selector: #selector(succesUpdate), name: NSNotification.Name("SuccesUpdate"), object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(errorAlert), name: NSNotification.Name("ErrorConnections"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RegisterationVC.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    func firstHideErrors()  {
        emailError.isHidden = true
        passwordError.isHidden = true
        confirmPasswordError.isHidden = true
        phoneError.isHidden = true
        othersError.isHidden = true
        jobTitleError.isHidden = true
        linkedInError.isHidden = true
        companyNameError.isHidden = true
        titleError.isHidden  = true
    }
    
    func firstHideHintLabel()  {
        emailLbl.isHidden = true
        passwordLbl.isHidden = true
        confirmPasswordLbl.isHidden = true
        phoneLbl.isHidden = true
        othersLbl.isHidden = true
        jobTitleLbl.isHidden = true
        linkedInLbl.isHidden = true
        companyNameLbl.isHidden = true
        titleLbl.isHidden  = true
    }
    
    @objc func succesUpdate(){
        activityLoader.stopAnimating()
        activityLoader.isHidden = true
        let alert = UIAlertController(title: "Succes!", message: "Your data is Updated!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func errorAlert(){
        if  SettingsVC.udapatedMessage == "" {
            let alert = UIAlertController(title: "Error!", message: Service.errorConnection, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // startupTableView.isHidden = true
            activityLoader.isHidden = true
            activityLoader.stopAnimating()
            //reload after
        } else {
            let alert = UIAlertController(title: "Error!", message: "Check Your Data !", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // startupTableView.isHidden = true
            activityLoader.isHidden = true
            activityLoader.stopAnimating()
            //reload after
            //
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    func textFieldsDelegats()  {
        emaiInputlTxt.delegate = self
        passwordInputTxt.delegate = self
        confirmPasswordInputTxt.delegate = self
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
            view.frame.origin.y = -200
            
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
            
        else if textField.isEqual(passwordInputTxt){
            passwordTriming = passwordInputTxt.text
            if passwordTriming?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && passwordTriming != nil && passwordTriming != "null" && (passwordTriming?.characters.count)! != 0 && (passwordTriming?.characters.count)! >= 6 {
                
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
            }
        }
        else if textField.isEqual(confirmPasswordInputTxt){
            if confirmPasswordInputTxt.text == passwordInputTxt.text {
                validPassword = true
            } else {
                confirmPasswordError.text = "Password doesn't match to each other"
                confirmPasswordError.isHidden = false
                validPassword = false
                
            }
        }
        return true
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
        else if textField.isEqual(confirmPasswordInputTxt){
            confirmPasswordError.isHidden = true
            confirmPasswordLbl.isHidden = false
        }
        else if textField.isEqual(jobTitleInput){
            jobTitleError.isHidden = true
            jobTitleLbl.isHidden = false
        }
        else if textField.isEqual(companyNameInputTxt){
            companyNameError.isHidden = true
            companyNameLbl.isHidden = false
        }
        else if textField.isEqual(linkedInInputTxt){
            linkedInError.isHidden = true
            linkedInLbl.isHidden = false
        }
        else if textField.isEqual(othersInputTxt){
            othersError.isHidden = true
            othersLbl.isHidden = false
        }
        else if textField.isEqual(titleInputTxt){
            titleError.isHidden = true
            titleLbl.isHidden = false
        }
        else if textField.isEqual(phoneInputTxt){
            phoneError.isHidden = true
            phoneLbl.isHidden = false
        }
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKyebad()
        self.view.endEditing(true)
        return true
    }
    
    @IBAction func imageSelectBtn(_ sender: Any) {
         present(imagePicker,animated: true , completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            profileImg.image = image
            let jpegCompressionQuality: CGFloat = 0.3 // Set this to whatever suits your purpose
            if let base64String = UIImageJPEGRepresentation(image, jpegCompressionQuality)?.base64EncodedString() {
                // Upload base64String to your database
                imageProfileB64 = base64String
            }
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer)  {
        view.endEditing(true)
    }
    
    func  loadSettingData()  {
        if let userSettingData = Helper.getSettingUserData() {
            self.emaiInputlTxt.text = userSettingData[0]
            self.passwordInputTxt.text = userSettingData[1]
            self.confirmPasswordInputTxt.text = userSettingData[1]
            self.jobTitleInput.text = userSettingData[2]
            self.phoneInputTxt.text = userSettingData[3]
            self.othersInputTxt.text = userSettingData[4]
            self.titleInputTxt.text = userSettingData[5]
            self.companyNameInputTxt.text = userSettingData[6]
            self.linkedInInputTxt.text = userSettingData[7]
            Helper.loadImagesKingFisher(imgUrl: userSettingData[8], ImgView: profileImg)
        } else {
        Service.getServiceWithAuth(url: URLs.getSettingData){
            (response) in
            print(response)
            let result = JSON(response)
            let user_Name = result["Title"].string
            let user_JobTitle = result["jobTitle"].string
            let user_CompanyName = result["companyName"].string
            let user_ImageUrl = result["picture"].string
            let user_Password = result["password"].string
            let user_Email = result["email"].string
            let user_Linkedin = result["linkedin"].string
            let user_Phone = result["phone"].string
            let user_about = result["about"].string
            let user_Ispublic_str = result["isPublic"].string
            self.statSettingList = [user_Email!,user_Password!,user_JobTitle!,user_Phone!,user_about!,user_Ispublic_str!]
           
            }
        }
    }
 
   
    @IBAction func btnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateProfileData()  {
        guard validEmail else {
            emailError.isHidden = false
            emailError.text = "you have an Error in filling Email"
            return
        }
        
        guard validPassword else {
            passwordError.isHidden = false
            passwordError.text = "you have an Error in filling Password"
            return } // registerAnswerList?[2] for confirm password
        guard let tiltleUser = titleInputTxt.text  else { return }
        guard let companyName = companyNameInputTxt.text  else { return }
        
        guard let jobTiltle = jobTitleInput.text else { return }
        guard let phoneNum = phoneInputTxt.text   else { return }
        guard let linkedIn = linkedInInputTxt.text   else { return }
        
        guard  let about = othersInputTxt.text  else { return }
        activityLoader.isHidden = false
        activityLoader.startAnimating()
        
        API.updateUserData(Email:  (emaiInputlTxt.text?.lowercased())!, Password: passwordInputTxt.text!, Title: tiltleUser , CompanyName: companyName , JobTitle: jobTiltle, About: about , Phone: phoneNum, Picture: imageProfileB64 ?? "", Linkedin: linkedIn , Ispublic: "True") { (error: Error?,succes:Bool) in
            if succes {
                print("Succes")
            }
     /*
            let alert = UIAlertController(title: "Succes!", message: "Your data is Updated!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil) */
        }
    }
    
    @IBAction func btnDone(_ sender: Any) {
     updateProfileData()
    }
}




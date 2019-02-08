//
//  RegisterationVC.swift
//  Elshams
//
//  Created by mac on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class RegisterationVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate  , UITableViewDelegate , UITableViewDataSource  {
    

    @IBOutlet weak var regestrationTableView: UITableView!
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
    var registerAnswerList :[String]?
    
  //  var validnumber:Bool?
    var validPassword:Bool?
    var validEmail:Bool?
    var quest = ["Email","Password","Confirm Password","Title","CompanyName","Job Title","Phone","linkedin","About"]

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
        NotificationCenter.default.addObserver(self, selector: #selector(succesRegister), name: NSNotification.Name("SuccesRegister"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RegisterationVC.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)

    }
    
    @objc func succesRegister(){
      
        let alert = UIAlertController(title: "Succes!", message: "You are just registered!", preferredStyle: UIAlertControllerStyle.alert)
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
            view.frame.origin.y = -150
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quest.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCell(withIdentifier: "registerscell") as! RegistrationCell
       //     cell.lblQuestQuest.text = quest[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "registerscell", for: indexPath) as! RegistrationCell
         cell.lblQuestQuest.text = quest[indexPath.row]
        return cell
    }
    
    func registertionTableData()-> [String]  {
        var linkedinCell : String?
        let i = IndexPath(row: 0, section: 0)
        let cell: RegistrationCell = self.regestrationTableView.cellForRow(at: i) as! RegistrationCell
        let emailCell = cell.txtAnswer.text!
        
        let i1 = IndexPath(row: 1, section: 0)
        let cell1: RegistrationCell = self.regestrationTableView.cellForRow(at: i1) as! RegistrationCell
        let passawordCell = cell1.txtAnswer.text!
        
        let i2 = IndexPath(row: 2, section: 0)
        let cell2: RegistrationCell = self.regestrationTableView.cellForRow(at: i2) as! RegistrationCell
        let confirmPassawordCell = cell2.txtAnswer.text!
        
        let i3 = IndexPath(row: 3, section: 0)
        let cell3: RegistrationCell = self.regestrationTableView.cellForRow(at: i3) as! RegistrationCell
        let titleCell = cell3.txtAnswer.text!
        
        let i4 = IndexPath(row: 4, section: 0)
        let cell4: RegistrationCell = self.regestrationTableView.cellForRow(at: i4) as! RegistrationCell
        let companyNameCell = cell4.txtAnswer.text!
        
        let i5 = IndexPath(row: 5, section: 0)
        let cell5: RegistrationCell = self.regestrationTableView.cellForRow(at: i5) as! RegistrationCell
        let jobTitleCell = cell5.txtAnswer.text!

        let i6 = IndexPath(row: 6, section: 0)
        let cell6: RegistrationCell = self.regestrationTableView.cellForRow(at: i6) as! RegistrationCell
        let phoneCell = cell6.txtAnswer.text!
      //keyborad
        
        let i7 = IndexPath(row: 7, section: 0)
        let cell7: RegistrationCell = self.regestrationTableView.cellForRow(at: i7) as! RegistrationCell
        if !((cell7.txtAnswer.text?.isEmpty)!) {
             linkedinCell = cell7.txtAnswer.text!

        }else {
             linkedinCell = ""

        }
        
        let i8 = IndexPath(row: 8, section: 0)
        let cell8: RegistrationCell = self.regestrationTableView.cellForRow(at: i8) as! RegistrationCell
        let aboutCell = cell8.txtAnswer.text!
        
        
        return [emailCell,passawordCell,confirmPassawordCell,titleCell,companyNameCell,jobTitleCell,phoneCell,linkedinCell ?? "",aboutCell]
    
    }
    @IBAction func register(_ sender: Any) {
        registerAnswerList = registertionTableData()
        guard let email = registerAnswerList?[0].trimmed,isValidEmail(emailID: email), !email.isEmpty else { return }
        guard let password = registerAnswerList?[1], !password.isEmpty else { return } // registerAnswerList?[2] for confirm password
        guard let tiltleUser = registerAnswerList?[3]  else { return }
        guard let companyName = registerAnswerList?[4]  else { return }

        guard let jobTiltle = registerAnswerList?[5] else { return }
        guard let phoneNum = registerAnswerList?[6]   else { return }
        guard let linkedIn = registerAnswerList?[7]   else { return }

        guard  let about = registerAnswerList?[8]   else { return }
     
        if TimeLineHomeVC.failMessage !=  "fail" {
            API.register(Email: email.lowercased(), Password: password, Title: tiltleUser , CompanyName: companyName, JobTitle: jobTiltle, About: about, Phone: phoneNum, Picture: imageProfileB64 ?? "", Linkedin: linkedIn) { (error: Error?,succes:Bool) in
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


/* guard let email = emaiInputlTxt.text?.trimmed, !email.isEmpty else { return }
 guard let password = passwordInputTxt.text, !password.isEmpty else { return }
 guard let jobTiltle = jobTitleInput.text?.trimmed , !jobTiltle.isEmpty else { return }
 guard let phoneNum = phoneInputTxt.text?.trimmed , !phoneNum.isEmpty else { return }
 guard  let other = othersInputTxt.text?.trimmed , !other.isEmpty else { return }
 */

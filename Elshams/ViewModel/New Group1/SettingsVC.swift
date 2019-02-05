//
//  SettingsVC.swift
//  Elshams
//
//  Created by mac on 12/23/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON

class SettingsVC: UIViewController , UITableViewDelegate , UITableViewDataSource , UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate{

    var settingList = Array<UserData>()
    var statSettingList : [String]?
    var cellSettingList : [String]?

    var sections = ["Information","Praivacy"]
    var quest = ["Email","Password","Job Title","Phone","Other"]
  //  var ans =  ["Kzaky@ikdynamics.com","12345","IOS Developer","01060136503","NO"]
    var privacy = ["public"]
   // var ansPraivacy
    var imageProfileB64 : String?

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var updateBtn: UIButton!
    static var udapatedMessage = ""
    var validPassword:Bool?
    var validEmail:Bool?
    var imagePicker: UIImagePickerController!

    // var userTriming:String?
    var passwordTriming:String?
    var emailTrim:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImg.layer.cornerRadius = profileImg.frame.width / 2
        profileImg.clipsToBounds = true
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if let  apiToken  = Helper.getApiToken() {
            profileImg.isHidden = false
            updateBtn.isHidden = false
            loadSettingData()
        
        }else{
            //view.isHidden = true
            profileImg.isHidden = true
            settingTableView.isHidden = true
            updateBtn.isHidden = true
            let alert = UIAlertController(title: "Error", message: "You must sign in to Show this Part", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
          //  dismiss(animated: true, completion: nil)
        }
        
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
        let i = IndexPath(row: 1, section: 0)
        let cell: SettingsCell = self.settingTableView.cellForRow(at: i) as! SettingsCell
        let emailCell = cell.txtAnswer.text!
        cell.txtAnswer.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    //    self.settingTableView.endEditing(true)
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKyebad()
        self.view.endEditing(true)
        return true
    }
    
    @IBAction func imageSelectBtn(_ sender: Any) {
         present(imagePicker,animated: true , completion: nil)
    }
    
    /* @IBAction func imageSelect(_ sender: Any) {
        present(imagePicker,animated: true , completion: nil)
        
    } */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            profileImg.image = image
            let jpegCompressionQuality: CGFloat = 0.3 // Set this to whatever suits your purpose
            if let base64String = UIImageJPEGRepresentation(image, jpegCompressionQuality)?.base64EncodedString() {
                // Upload base64String to your database
                imageProfileB64 = base64String
          //      print(base64String)
            }
            
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer)  {
        view.endEditing(true)
    }
    
    func  loadSettingData()  {
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
            self.settingTableView.reloadData()
            self.imgUrl(imgUrl: user_ImageUrl!)
        }
    }
 
    
    func imgUrl(imgUrl:String)  {
        if  TimeLineHomeVC.failMessage !=  "fail"{
        if let imagUrlAl = imgUrl as? String {
            Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                print(response)
                if let image = response.result.value {
                    DispatchQueue.main.async{
                        self.profileImg.image = image
                    }
                }
            })
        }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return quest.count
        } else {
            return privacy.count
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingscell") as! SettingsCell
        if indexPath.section == 0 {
            cell.lblNameQuest.text = quest[indexPath.row]
            if statSettingList != nil {
            cell.txtAnswer.text = statSettingList![indexPath.row]
            }
            cell.privacySwitch.isHidden = true
        }
        else {
            cell.lblNameQuest.text = privacy[indexPath.row]
            cell.lblNameQuest.frame.origin.y = 30.0
            cell.txtAnswer.isHidden = true
            if statSettingList != nil {

            if statSettingList![5].lowercased() == "true" {
                cell.privacySwitch.isOn = true

            }else {
                cell.privacySwitch.isOn = false

            }
            }
        }
        return cell
    }

    @IBAction func btnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDone(_ sender: Any) {
        //alert
      /*  for ind in 0..<5 {
            let index = IndexPath(row: ind, section: 0)
            let cell: SettingsCell = self.settingTableView.cellForRow(at: index) as! SettingsCell
            let txtCell = cell.txtAnswer.text!
            cellSettingList?.append(txtCell)
            print(cellSettingList)

            cellSettingList?[ind].append(contentsOf:  txtCell)
            print(cellSettingList)
        }*/
        let i = IndexPath(row: 0, section: 0)
        let cell: SettingsCell = self.settingTableView.cellForRow(at: i) as! SettingsCell
        let emailCell = cell.txtAnswer.text!
        
        let i1 = IndexPath(row: 1, section: 0)
        let cell1: SettingsCell = self.settingTableView.cellForRow(at: i1) as! SettingsCell
        let passawordCell = cell1.txtAnswer.text!
        
        let i2 = IndexPath(row: 2, section: 0)
        let cell2: SettingsCell = self.settingTableView.cellForRow(at: i2) as! SettingsCell
        let jobTitleCell = cell2.txtAnswer.text!
        
        let i3 = IndexPath(row: 3, section: 0)
        let cell3: SettingsCell = self.settingTableView.cellForRow(at: i3) as! SettingsCell
        let phoneCell = cell3.txtAnswer.text!
        
        let i4 = IndexPath(row: 4, section: 0)
        let cell4: SettingsCell = self.settingTableView.cellForRow(at: i4) as! SettingsCell
        let otherCell = cell4.txtAnswer.text!
        
        let i5 = IndexPath(row: 0, section: 1)
        let cell5: SettingsCell = self.settingTableView.cellForRow(at: i5) as! SettingsCell
        let isPublicSwitchCell = cell5.privacySwitch
        var isPublicCell = ""
        if isPublicSwitchCell?.isOn == true {
            isPublicCell = "True"
        } else {
            isPublicCell = "False"

        }
        
       /* guard let email = emailCell.trimmed, !email.isEmpty, let password = passawordCell, !password.isEmpty, let jobTiltle = jobTitleCell.trimmed , !jobTiltle.isEmpty, let phoneNum = otherCell.trimmed , !phoneNum.isEmpty , let other = otherCell.trimmed , !other.isEmpty else { return } */
        
        API.updateUserData(Email: emailCell.lowercased(), Password: passawordCell, Title: otherCell , CompanyName: jobTitleCell, JobTitle: jobTitleCell, About: jobTitleCell, Phone: phoneCell, Picture: imageProfileB64 ?? "", Linkedin: "", Ispublic: isPublicCell) { (error: Error?,succes:Bool) in
                if succes {
                    print("Succes")
                }
            let alert = UIAlertController(title: "Succes!", message: "Your data is Updated!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
     //   updateSettingData()
    }
    }
}


/*  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
 let headerView = UIView()
 headerView.backgroundColor = UIColor.seemGray
 headerView.frame.size.height = 80
 let headerLabel = UILabel(frame: CGRect(x: 30, y: 25, width:
 tableView.bounds.size.width, height: tableView.bounds.size.height))
 headerLabel.font = UIFont(name: "Verdana", size: 13)
 headerLabel.textColor = UIColor.seemDrakGray
 headerLabel.text = self.tableView(self.tblPl, titleForHeaderInSection: section)
 headerLabel.sizeToFit()
 headerView.addSubview(headerLabel)
 return headerView
 }
 */

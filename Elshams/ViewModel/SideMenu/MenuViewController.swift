//
//  MenuViewController.swift
//  Elshams
//
//  Created by mac on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
//import AlamofireImage
import Alamofire
import SwiftyJSON
import Kingfisher

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    static var agendaEventOrMenu:Bool = false
    static var speakerEventOrMenu:Bool = false
    static var sponserEventOrMenu:Bool = false
    static var startupEventOrMenu:Bool = false
    var imgUserUrl:String?
    static var imgUserTestUrl:String = ""

    @IBOutlet weak var userProfile: UIImageView!
    
    var btnMenu : UIButton!
    var SideMenuTitles = ["TimeLine","Myfavorites","Agenda","Speakers","Sponsers","Exhibitors","Innovation","Startups","News","Notifications","Questions","Appointment","Settings","Logout"] //,"AllEvents" "Networks",
    var SideMenuIcons = ["home","favourite","agenda","speaker","sponsers","startup","agenda","startup","news","notifications","questation","appointment","home","logout"]//"events", "networks",
    @IBOutlet weak var btnCloseMenuOverlay: UIButton!
    var delegate : SlideMenuDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLbl.isHidden = true
        jobTitle.isHidden = true
        
        userProfile.layer.cornerRadius = userProfile.frame.width / 2
        userProfile.clipsToBounds = true
        NotificationCenter.default.addObserver(self, selector: #selector(errorAlert), name: NSNotification.Name("ErrorConnections"), object: nil)
      //  btnCloseMenuOverlay.backgroundColor = UIColor.red
       loadCasheDate()
      //  loadUserData()
    //    imgUrl(imgUrl: MenuViewController.imgUserTestUrl)
       
    }
    @objc func errorAlert(){
        let alert = UIAlertController(title: "Error!", message: Service.errorConnection, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        //  startupTableView.isHidden = true
      //  activeLoader.isHidden = true
        //  activeLoader.stopAnimating()
        //reload after
        //
    }
    
    func loadCasheDate()  {
        if let  apiToken  = Helper.getApiToken() {
            btnLogin.isHidden = true
            btnRegister.isHidden = true
            if let user_Name = Helper.getUserName() {
                self.userNameLbl.isHidden = false
                self.userNameLbl.text = user_Name
            }
            if let user_JobTitle = Helper.getUserJobTitle() {
                self.jobTitle.isHidden = false
                self.jobTitle.text = user_JobTitle
            }
         
            if let user_ImageUrl = Helper.getUserImageUrl() {
                Helper.loadImagesKingFisher(imgUrl: (user_ImageUrl), ImgView: userProfile)

            }
        } else {
            btnLogin.isHidden = false
            btnRegister.isHidden = false
            userNameLbl.isHidden = true
            jobTitle.isHidden = true
        }
    }
    
    
    func  loadUserData()  {
        if let  apiToken  = Helper.getApiToken() {
            btnLogin.isHidden = true
            btnRegister.isHidden = true
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
                
            } else {
                self.userNameLbl.isHidden = false
                self.userNameLbl.text = user_Name!
                self.jobTitle.isHidden = false
                self.jobTitle.text = user_JobTitle!
            }
           
            if user_ImageUrl != nil {
               // self.imgUrl(imgUrl: (user_ImageUrl)!)
                Helper.loadImagesKingFisher(imgUrl: (user_ImageUrl)!, ImgView: self.userProfile)
            }
        }
        } else {
            btnLogin.isHidden = false
            btnRegister.isHidden = false
            userNameLbl.isHidden = true
            jobTitle.isHidden = true
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SideMenuTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sidemenucell") as! SideMenuDetailCell
        cell.titleCell.text = SideMenuTitles[indexPath.row]
        cell.iconImg.image = UIImage(named: SideMenuIcons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var controllerSelect : String?
        switch indexPath.row {
        case 0:
            controllerSelect = "TimeLine"
   //     case 1 :
       //     controllerSelect = "NetworkSpeakers"

        case 1 :
            if let  apiToken  = Helper.getApiToken() {

            controllerSelect = "MyFavouriteAgenda"
                
            } else {
                controllerSelect = "NotLogin"
                
            }
            
        case 2 :
            controllerSelect = "EventAgenda"
            MenuViewController.agendaEventOrMenu = true
        case 3 :
            controllerSelect = "EventSpeakers"
            MenuViewController.speakerEventOrMenu = true
        case 4 :
            controllerSelect = "EventSponsers"
            MenuViewController.sponserEventOrMenu = true
        case 5 :
            controllerSelect = "EventExhibitors"
            MenuViewController.startupEventOrMenu = true
        case 6 :
            controllerSelect = "EventInnovation"
        case 7 :
            controllerSelect = "EventStartups"
            MenuViewController.startupEventOrMenu = true

        case 8 :
            controllerSelect = "AllNews"
            
        case 9 :
            if let  apiToken  = Helper.getApiToken() {

            controllerSelect = "NotificationEvent"
        } else {
            controllerSelect = "NotLogin"
            
        }
        case 10 :
        if let  apiToken  = Helper.getApiToken() {

            controllerSelect = "QuestionsContainer"
    } else {
    controllerSelect = "NotLogin"
    
    }
        
        case 11 :
            if let  apiToken  = Helper.getApiToken() {
            controllerSelect = "AppointmentContainer"
            } else {
                controllerSelect = "NotLogin"
               
            }
    /*    case 11 :
            controllerSelect = "AllMainEvents" //EventContainer
            MenuViewController.agendaEventOrMenu = true */
        case 12 :
             if let  apiToken  = Helper.getApiToken() {
            controllerSelect = "Settings"
            
        } else {
            controllerSelect = "NotLogin"
            
        }
        case 13 :
            controllerSelect = "Logout"
            let def = UserDefaults.standard
            def.setValue(nil, forKey: "api_token")
            def.synchronize()
            performSegue(withIdentifier: "login", sender: nil)

            let userProfile = UserDefaults.standard
            userProfile.setValue(nil, forKey: "user_profileurl")
            userProfile.synchronize()
            let userName = UserDefaults.standard
            userName.setValue(nil, forKey: "user_name")
            userName.synchronize()
            let userJobTitle = UserDefaults.standard
            userJobTitle.setValue(nil, forKey: "user_jobtitle")
            userJobTitle.synchronize()
            let userSettingData = UserDefaults.standard
            userSettingData.setValue(nil, forKey: "user_data")
            userSettingData.synchronize()
        
        default:
            controllerSelect = "EventAgenda"

        }
        
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if controllerSelect != "Logout" && controllerSelect != "NotLogin"{
            if controllerSelect != "Settings"{
                let DVC = mainStoryBoard.instantiateViewController(withIdentifier: controllerSelect!)
                self.navigationController?.pushViewController(DVC, animated: true)
            }

            else {
                performSegue(withIdentifier: "settingspage", sender: nil)
             //   let DVC = mainStoryBoard.instantiateViewController(withIdentifier: controllerSelect!)
              //  self.navigationController?.pus(DVC, animated: true)
            }  
        }
       /* else if controllerSelect == "Logout"{
            let DVC = mainStoryBoard.instantiateViewController(withIdentifier: controllerSelect!)
            self.navigationController?.pushViewController(DVC, animated: true)
        } */
            
        else if controllerSelect == "NotLogin" {
            let alert = UIAlertController(title: "Not Allowed", message: "You must sign in to Show this Part", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            //dismiss(animated: true, completion: nil)
        }
     
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    @IBAction func btnRegister(_ sender: Any) {
         performSegue(withIdentifier: "register", sender: nil)
    }
    @IBAction func btnLogin(_ sender: Any) {
        let def = UserDefaults.standard
        def.setValue(nil, forKey: "api_token")
        def.synchronize()
        performSegue(withIdentifier: "login", sender: nil)
    }
    
    @IBAction func settingImageMethod(_ sender: Any) {
if let  apiToken  = Helper.getApiToken() {
      performSegue(withIdentifier: "settingspage", sender: nil)
        }
        
        }
    @IBAction func btnCloseTapped(_ sender: UIButton) {
        btnMenu.tag = 0
        btnMenu.isHidden = false
        if (self.delegate != nil) {
            var index = Int32(sender.tag)
            if(sender == self.btnCloseMenuOverlay){
                index = -1
            }
            
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        })
        btnCloseMenuOverlay.backgroundColor = UIColor.clear

        //think black here
    }
    

}

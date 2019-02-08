//
//  MenuViewController.swift
//  Elshams
//
//  Created by mac on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON
protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    static var agendaEventOrMenu:Bool = false
    static var speakerEventOrMenu:Bool = false
    static var sponserEventOrMenu:Bool = false
    static var startupEventOrMenu:Bool = false
    var imgUserUrl:String?
    static var imgUserTestUrl:String = ""

    @IBOutlet weak var userProfile: UIImageView!
    
    var btnMenu : UIButton!
    var SideMenuTitles = ["TimeLine","Myfavorites","Agenda","Speakers","Sponsers","Startups","News","Notifications","Questions","Appointment","Settings","Logout"] //,"AllEvents" "Networks",
    var SideMenuIcons = ["home","favourite","agenda","speaker","sponsers","startup","news","notifications","questation","appointment","home","logout"]//"events", "networks",
    @IBOutlet weak var btnCloseMenuOverlay: UIButton!
    var delegate : SlideMenuDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfile.layer.cornerRadius = userProfile.frame.width / 2
        userProfile.clipsToBounds = true
        loadUserData()
    //    imgUrl(imgUrl: MenuViewController.imgUserTestUrl)
       
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
            let user_ImageUrl = result["picture"].string
            let user_Password = result["password"].string
            let user_Email = result["email"].string
            let user_Linkedin = result["linkedin"].string
            let user_Phone = result["phone"].string
            let user_about = result["about"].string
            let user_Ispublic_str = result["isPublic"].string
           // self.imgUserUrl = user_ImageUrl
            // internet error handel
            self.imgUrl(imgUrl: (user_ImageUrl)!)
        }
        }
    }
    func imgUrl(imgUrl:String)  {
        if  TimeLineHomeVC.failMessage !=  "fail"{
        if let imagUrlAl = imgUrl as? String {
            Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                print(response)
                if let image = response.result.value {
                    DispatchQueue.main.async{
                        self.userProfile.image = image
                    }
                }
            })
        }
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
            controllerSelect = "EventStartups"
            MenuViewController.startupEventOrMenu = true

        case 6 :
            controllerSelect = "AllNews"
            
        case 7 :
            if let  apiToken  = Helper.getApiToken() {

            controllerSelect = "NotificationEvent"
        } else {
            controllerSelect = "NotLogin"
            
        }
        case 8 :
        if let  apiToken  = Helper.getApiToken() {

            controllerSelect = "QuestionsContainer"
    } else {
    controllerSelect = "NotLogin"
    
    }
        
        case 9 :
            if let  apiToken  = Helper.getApiToken() {
            controllerSelect = "AppointmentContainer"
            } else {
                controllerSelect = "NotLogin"
               
            }
    /*    case 11 :
            controllerSelect = "AllMainEvents" //EventContainer
            MenuViewController.agendaEventOrMenu = true */
        case 10 :
             if let  apiToken  = Helper.getApiToken() {
            controllerSelect = "Settings"
            
        } else {
            controllerSelect = "NotLogin"
            
        }
        case 11 :
            //fe sho8l hna kteer 3shan el remember me
            controllerSelect = "Logout"
            let def = UserDefaults.standard
            def.setValue(nil, forKey: "api_token")
            def.synchronize()
            performSegue(withIdentifier: "login", sender: nil)

           // dismiss(animated: true, completion: nil)
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
            let alert = UIAlertController(title: "Error", message: "You must sign in to Show this Part", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            //dismiss(animated: true, completion: nil)
        }
     
        
        
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
    }
    

}

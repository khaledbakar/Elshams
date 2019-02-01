//
//  MenuViewController.swift
//  Elshams
//
//  Created by mac on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    static var agendaEventOrMenu:Bool = false
    static var speakerEventOrMenu:Bool = false
    static var sponserEventOrMenu:Bool = false
    static var startupEventOrMenu:Bool = false


    var btnMenu : UIButton!
    var SideMenuTitles = ["TimeLine","Networks","Myfavorites","Agenda","Speakers","Sponsers","Startups","News","Notifications","Questions","Appointment","Settings","Logout"] //,"AllEvents"
    var SideMenuIcons = ["home","networks","favourite","agenda","speaker","sponsers","startup","news","notifications","questation","appointment","home","logout"]//"events",
    @IBOutlet weak var btnCloseMenuOverlay: UIButton!
    var delegate : SlideMenuDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        case 1 :
            controllerSelect = "NetworkSpeakers"

        case 2 :
            controllerSelect = "MyFavouriteAgenda"
            
        case 3 :
            controllerSelect = "EventAgenda"
            MenuViewController.agendaEventOrMenu = true
        case 4 :
            controllerSelect = "EventSpeakers"
            MenuViewController.speakerEventOrMenu = true
        case 5 :
            controllerSelect = "EventSponsers"
            MenuViewController.sponserEventOrMenu = true
        case 6 :
            controllerSelect = "EventStartups"
            MenuViewController.startupEventOrMenu = true

        case 7 :
            controllerSelect = "AllNews"
            
        case 8 :
            controllerSelect = "NotificationEvent"
        case 9 :
            controllerSelect = "QuestionsContainer"
        case 10 :
            controllerSelect = "AppointmentContainer"
    /*    case 11 :
            controllerSelect = "AllMainEvents" //EventContainer
            MenuViewController.agendaEventOrMenu = true */
        case 11 :
            controllerSelect = "Settings"
        case 12 :
            //fe sho8l hna kteer 3shan el remember me
            controllerSelect = "Logout"
            let def = UserDefaults.standard
            def.setValue(nil, forKey: "api_token")
            def.synchronize()
            dismiss(animated: true, completion: nil)
        default:
            controllerSelect = "EventAgenda"

        }
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if controllerSelect != "Logout"{
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

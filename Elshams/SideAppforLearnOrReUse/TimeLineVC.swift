//
//  TimeLineVC.swift
//  Elshams
//
//  Created by mac on 11/27/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class TimeLineVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showSetting), name: NSNotification.Name("ShowSetting"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showLogout), name: NSNotification.Name("ShowLogOut"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showProfile), name: NSNotification.Name("ShowProfile"), object: nil)
        // Do any additional setup after loading the view.
    }
    @objc func showProfile(){
        //performSegue(withIdentifier: "ShowProfile", sender: nil)
        print("Profile")
    }
    @objc func showSetting(){
       // performSegue(withIdentifier: "ShowSetting", sender: nil)
        print("setting")

    }
    @objc func showLogout(){
       // performSegue(withIdentifier: "ShowLogOut", sender: nil)
        print("logout")

    }
    @IBAction func onHamMenu (){
        print("Toggle Side menu")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }

}

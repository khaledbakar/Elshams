//
//  SideMenuVCTableViewController.swift
//  Elshams
//
//  Created by mac on 11/27/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class SideMenuVCTableViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
  
        var menuList = ["Timeline","Companies","Agents","All events","News","Notification","Settings","Logout"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SideMenuCell
        cell.sideLabels.text = menuList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        switch indexPath.row {
        case 0:
            NotificationCenter.default.post(name: NSNotification.Name("ShowProfile"), object: nil)
        case 1:
            NotificationCenter.default.post(name: NSNotification.Name("ShowSetting"), object: nil)
        case 2:
            NotificationCenter.default.post(name: NSNotification.Name("ShowLogOut"), object: nil)
        default:
            break
            
            
        }
    }
   
   // tableview

   

}

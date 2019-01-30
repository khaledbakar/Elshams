//
//  PendingVC.swift
//  Elshams
//
//  Created by mac on 12/6/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import AlamofireImage
import SwiftyJSON

class PendingVC: BaseViewController , UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var pendingTableView: UITableView!
    @IBOutlet weak var activeLoader: UIActivityIndicatorView!
    var pendingList = Array<StartUpsData>()

    override func viewDidLoad() {
        super.viewDidLoad()
         addSlideMenuButton()
        
        pendingTableView.isHidden = true
        activeLoader.startAnimating()
        loadPendingAppointmentsData()
      
    }
    
    
    func loadPendingAppointmentsData()  {
        Service.getServiceWithAuth(url: URLs.getAppoiments) {
            (response) in
            print(response)
            let json = JSON(response)
            let result = json["pending"]
            var iDNotNull = true
            var index = 0
            while iDNotNull {
                let startUp_ID = result[index]["id"].string
                let startUp_Name = result[index]["title"].string
                let startUp_Appoimentstatus = result[index]["appoimentstatus"].string
                let startUp_AppoimentTime = result[index]["AppoimentTime"].string
                let startUp_ImageUrl = result[index]["imageURl"].string
                let startUp_About = result[index]["about"].string
                let startUp_ContectInforamtion = result[index]["ContectInforamtion"].dictionaryObject
                let startUp_Email = result[index]["ContectInforamtion"]["Email"].string
                let startUp_Linkedin = result[index]["ContectInforamtion"]["linkedin"].string
                let startUp_Phone = result[index]["ContectInforamtion"]["phone"].string
                
                let contect = ["Email": "",
                               "linkedin": "",
                               "phone": ""]
                if startUp_ID == nil || startUp_ID?.trimmed == "" || startUp_ID == "null" || startUp_ID == "nil" {
                    iDNotNull = false
                    break
                }
                self.pendingList.append(StartUpsData(StartupName: startUp_Name ?? "name", StartupID: startUp_ID ?? "ID", StartupImageURL: startUp_ImageUrl ?? "Image", StartUpAbout: startUp_About ?? "about", AppoimentStatus: startUp_Appoimentstatus ?? "Appointmentstatus", AppoimentTime: startUp_AppoimentTime ?? "AppoimentTime", ContectInforamtion: startUp_ContectInforamtion ?? contect))
                index = index + 1
                self.pendingTableView.reloadData()
                self.activeLoader.isHidden = true
                self.activeLoader.stopAnimating()
                self.pendingTableView.isHidden = false
            }
        }
    }
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pendingList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pendingcell") as! PendingCell
        cell.setStartupCell(startupsList: pendingList[indexPath.row])

        return cell
    }
    
    @IBAction func btnRescudule(_ sender: Any) {
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to:self.pendingTableView)
        let indexPath = self.pendingTableView.indexPathForRow(at: buttonPosition)
        StartupDetailsVC.sechadualeBTNSend = true
        performSegue(withIdentifier: "pendingstartup", sender: pendingList[indexPath!.row])
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to:self.pendingTableView)
        let indexPath = self.pendingTableView.indexPathForRow(at: buttonPosition)
   
        pendingList.remove(at: (indexPath?.row)!)
        pendingTableView.reloadData()
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "pendingstartup", sender: pendingList[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dis = segue.destination as? StartupDetailsVC {
            if let favDetail = sender as? StartUpsData {
                dis.singleItem = favDetail
            }
        }
    }
    
    
}

extension PendingVC : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Pending")
    }
}

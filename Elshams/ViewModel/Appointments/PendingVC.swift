//
//  PendingVC.swift
//  Elshams
//
//  Created by mac on 12/6/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PendingVC: BaseViewController , UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var pendingTableView: UITableView!
    //var startUpList = Array<StartUpsData>()
  var filterPending = StartUps.startUpList.filter { (($0.pendingApointmentStr?.contains("true"))!)}


    override func viewDidLoad() {
        super.viewDidLoad()
         addSlideMenuButton()
      /*  startUpList.append(StartUpsData(StartupName: "Bakar", StartupAddress: "1 Tahrir Square,cairo,Egypt", StartupImage: "avatar", StartUpLinkedIn: "khaled.zaki12", StartUpPhone: "01060136503", StartUpMail: "kzakyy@ikdynamics.com", StartUpAbout: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, ", AcceptedApointment: false, PendingApointment: true, AcceptedApointmentStr: "false", PendingApointmentStr: "true"))
        startUpList.append(StartUpsData(StartupName: "MedGram", StartupAddress: "18A Obour Bulidings,cairo,Egypt", StartupImage: "avatar", StartUpLinkedIn: "khaled.zaki12", StartUpPhone: "01060136503", StartUpMail: "kzakyy@ikdynamics.com", StartUpAbout: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, ", AcceptedApointment: false, PendingApointment: true, AcceptedApointmentStr: "false", PendingApointmentStr: "true")) */
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     //  return startUpList.count
        return filterPending.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pendingcell") as! PendingCell
       // cell.setStartupCell(startupsList: startUpList[indexPath.row])
        cell.setStartupCell(startupsList: filterPending[indexPath.row])

        return cell
    }
    
    @IBAction func btnRescudule(_ sender: Any) {
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to:self.pendingTableView)
        let indexPath = self.pendingTableView.indexPathForRow(at: buttonPosition)
        StartupDetailsVC.sechadualeBTNSend = true
        performSegue(withIdentifier: "pendingstartup", sender: filterPending[indexPath!.row])

      //  StartupDetailsVC.sechadualeBTNSend = true
      //  performSegue(withIdentifier: "startupdetail", sender: StartUps.startUpList[indexPath!.row])
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to:self.pendingTableView)
        let indexPath = self.pendingTableView.indexPathForRow(at: buttonPosition)
        let selectedId = filterPending[indexPath!.row].id_startUp
        
        StartUps.startUpList[selectedId!].pendingApointment = false
        StartUps.startUpList[selectedId!].pendingApointmentStr = "false"
       
        filterPending.remove(at: (indexPath?.row)!)
        pendingTableView.reloadData()
        
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "pendingstartup", sender: filterPending[indexPath.row])
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

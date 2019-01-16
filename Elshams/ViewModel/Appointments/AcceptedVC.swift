//
//  AcceptedVC.swift
//  Elshams
//
//  Created by mac on 12/6/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class AcceptedVC: UIViewController , UITableViewDataSource ,UITableViewDelegate {
 
    var startUpList = Array<StartUpsData>()
 
    override func viewDidLoad() {
        super.viewDidLoad()

        startUpList.append(StartUpsData(StartupName: "Bakar", StartupAddress: "1 Tahrir Square,cairo,Egypt", StartupImage: "avatar", StartUpLinkedIn: "khaled.zaki12", StartUpPhone: "01060136503", StartUpMail: "kzakyy@ikdynamics.com", StartUpAbout: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, ", AcceptedApointment: true, PendingApointment: false))
        startUpList.append(StartUpsData(StartupName: "MedGram", StartupAddress: "18A Obour Bulidings,cairo,Egypt", StartupImage: "avatar", StartUpLinkedIn: "khaled.zaki12", StartUpPhone: "01060136503", StartUpMail: "kzakyy@ikdynamics.com", StartUpAbout: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, ", AcceptedApointment: true, PendingApointment: false))
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return startUpList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "acceptedcell") as! AcceptedCell
        cell.setStartupCell(startupsList: startUpList[indexPath.row])
        return cell
    }
  /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "acceptedcell", sender: startUpList[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dis = segue.destination as? StartupDetailsVC {
            if let favDetail = sender as? StartUpsData {
                dis.singleItem = favDetail
            }
        }
    } */
    
}

extension AcceptedVC : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Accepted")
    }
}

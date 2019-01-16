//
//  StartUps.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class StartUps: BaseViewController , UITableViewDelegate , UITableViewDataSource {
    var startUpList = Array<StartUpsData>()
    @IBOutlet weak var startupTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if MenuViewController.startupEventOrMenu == true {
            addSlideMenuButton()
          //  btnRightBar()
            self.navigationItem.title = "Startups"
            MenuViewController.startupEventOrMenu = false
            }
        startUpList.append(StartUpsData(StartupName: "El7ag Bakar", StartupAddress: "1 Tahrir Square,cairo,Egypt", StartupImage: "profile1", StartUpLinkedIn: "khaled.zaki12", StartUpPhone: "01060136503", StartUpMail: "kzakyy@ikdynamics.com", StartUpAbout: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, ", AcceptedApointment: true, PendingApointment: false))
        
        startUpList.append(StartUpsData(StartupName: "MedGram", StartupAddress: "18A Obour Bulidings,cairo,Egypt", StartupImage: "avatar", StartUpLinkedIn: "khaled.zaki12", StartUpPhone: "01060136503", StartUpMail: "kzakyy@ikdynamics.com", StartUpAbout: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, ", AcceptedApointment: false, PendingApointment: true))
        
        startUpList.append(StartUpsData(StartupName: "MedGram", StartupAddress: "18A Obour Bulidings,cairo,Egypt", StartupImage: "avatar", StartUpLinkedIn: "khaled.zaki12", StartUpPhone: "01060136503", StartUpMail: "kzakyy@ikdynamics.com", StartUpAbout: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, ", AcceptedApointment: false, PendingApointment: false))

    }
    
    func btnRightBar()  {
      //  let btnSearch = UIButton(type: UIButton.ButtonType.system)
        let btnSearch = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: nil, action:  #selector(searchTool))
      //  btnSearch.setImage(UIImage(named: "fav_resic"), for: UIControl.State())
     //   btnSearch.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
      //  btnSearch.addTarget(self, action: #selector(searchTool), for: UIControl.Event.touchUpInside)
      //  btnSearch.ba
    //    let customBarItem = UIBarButtonItem(customView: btnSearch)
       // self.navigationItem.rightBarButtonItem = customBarItem;
        self.navigationItem.rightBarButtonItem = btnSearch;

    }
    
    @objc func searchTool() {
        print("gooooood")
    }
    
    @IBAction func btnSechaduale(_ sender: Any) {
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to:self.startupTableView)
        let indexPath = self.startupTableView.indexPathForRow(at: buttonPosition)
        StartupDetailsVC.sechadualeBTNSend = true
        performSegue(withIdentifier: "startupdetail", sender: startUpList[indexPath!.row])
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return startUpList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "startupcell") as! StartUpsCell
        cell.setStartupCell(startupsList: startUpList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "startupdetail", sender: startUpList[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dis = segue.destination as? StartupDetailsVC {
            if let favDetail = sender as? StartUpsData {
                dis.singleItem = favDetail
            }
        }
    }
    
}

extension StartUps : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Startup")
    }
}


//
//  NetworksVC.swift
//  Elshams
//
//  Created by mac on 12/5/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class NetworksVC: BaseViewController , UITableViewDataSource , UITableViewDelegate {
    var networkList = Array<Networks>()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
  // self.UINavigationBar.color
        self.navigationItem.title = "Networks"

        networkList.append(Networks(NetworkName: "Khaled Bakar", JobTitle: "Programmer", jobDescribition: "IOSDeveloper", SpImage: "profile2", LinkedInLink: "Khaled.bakar12", Phone: "01060136503", Mail: "khaledbakar7@gmai.com", About: "one of the most importanat people in the life he hasn't title job his name is a title"))

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networkList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "networkcell") as! NetworksCell
        cell.setNetworkCell(networkList: networkList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "newtworkdetailpage", sender: networkList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dis = segue.destination as? NetworkDetailsVC {
            if let netDetail = sender as? Networks {
            dis.singleItem = netDetail
            }
    }
    }
    
}
/*
extension NetworksVC : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Networks")
}
*/

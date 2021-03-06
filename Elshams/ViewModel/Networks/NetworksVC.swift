//
//  NetworksVC.swift
//  Elshams
//
//  Created by mac on 12/5/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import AlamofireImage
import SwiftyJSON

class NetworksVC: BaseViewController , UITableViewDataSource , UITableViewDelegate {
    var  networkList = Array<Networks>()
    @IBOutlet weak var tableVIewNetwork: UITableView!
    
    @IBOutlet weak var activeLoader: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
  // self.UINavigationBar.color
        tableVIewNetwork.isHidden = true
        activeLoader.startAnimating()

        self.navigationItem.title = "Networks"
        loadTableData()
       // loadData()
      // print((networkList[0].name)!)


      /*  networkList.append(Networks(NetworkName: "Khaled Bakar", JobTitle: "Programmer", jobDescribition: "IOSDeveloper", SpImage: "profile2", LinkedInLink: "Khaled.bakar12", Phone: "01060136503", Mail: "khaledbakar7@gmai.com", About: "one of the most importanat people in the life he hasn't title job his name is a title"))
        */

    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    
    func loadTableData()  {
        if let  apiToken  = Helper.getApiToken() {

        Service.getServiceWithAuth(url: URLs.getNetwork) {
            (response) in
            print(response)
            let result = JSON(response)
            
            var iDNotNull = true
            var index = 0
            while iDNotNull {
                let network_ID = result[index]["ID"].string
                let network_Name = result[index]["name"].string
                let network_JobTitle = result[index]["jobTitle"].string
                let network_CompanyName = result[index]["companyName"].string
                let network_ImageUrl = result[index]["imageUrl"].string
                let network_RequestSenderID = result[index]["requestSenderID"].string
                let network_RequestStatus = result[index]["requestStatus"].string
                if network_Name == nil || network_Name?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || network_Name == "null" {
                    iDNotNull = false
                    break
                }
                self.networkList.append(Networks(NetworkName: network_Name ?? "noname", JobTitle: network_JobTitle ?? "null", ImageUrl: network_ImageUrl ?? "null", CompanyName: network_CompanyName ?? "null", NetworkID: network_ID ?? "null", RequestStatus: network_RequestStatus ?? "null", RequestSenderID: network_RequestSenderID ?? "null"))
                index = index + 1
                self.tableVIewNetwork.reloadData()
                self.activeLoader.isHidden = true
                self.activeLoader.stopAnimating()
                self.tableVIewNetwork.isHidden = false
            }
            //  print((self.networkList[2].name)!)
        }
        }else {
            Service.getService(url: URLs.getNetwork) {
                (response) in
                print(response)
                let result = JSON(response)
                
                var iDNotNull = true
                var index = 0
                while iDNotNull {
                    let network_ID = result[index]["ID"].string
                    let network_Name = result[index]["name"].string
                    let network_JobTitle = result[index]["jobTitle"].string
                    let network_CompanyName = result[index]["companyName"].string
                    let network_ImageUrl = result[index]["imageUrl"].string
                    let network_RequestSenderID = result[index]["requestSenderID"].string
                    let network_RequestStatus = result[index]["requestStatus"].string
                    if network_Name == nil || network_Name?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || network_Name == "null" {
                        iDNotNull = false
                        break
                    }
                    self.networkList.append(Networks(NetworkName: network_Name ?? "noname", JobTitle: network_JobTitle ?? "null", ImageUrl: network_ImageUrl ?? "null", CompanyName: network_CompanyName ?? "null", NetworkID: network_ID ?? "null", RequestStatus: network_RequestStatus ?? "null", RequestSenderID: network_RequestSenderID ?? "null"))
                    index = index + 1
                    self.tableVIewNetwork.reloadData()
                    self.activeLoader.isHidden = true
                    self.activeLoader.stopAnimating()
                    self.tableVIewNetwork.isHidden = false
                }
        }
        
    }
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
        tableView.deselectRow(at: indexPath, animated: true)
        if let  apiToken  = Helper.getApiToken() {
        performSegue(withIdentifier: "newtworkdetailpage", sender: networkList[indexPath.row])
        }else {
            let alert = UIAlertController(title: "Error", message: "You must sign in to Show this Part", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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

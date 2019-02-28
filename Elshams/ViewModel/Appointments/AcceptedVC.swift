//
//  AcceptedVC.swift
//  Elshams
//
//  Created by mac on 12/6/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire
//import AlamofireImage
import SwiftyJSON


class AcceptedVC: BaseViewController , UITableViewDataSource ,UITableViewDelegate {
    var acceptedList = Array<StartUpsData>()
    @IBOutlet weak var acceptedTableView: UITableView!
    @IBOutlet weak var activeLoader: UIActivityIndicatorView!
    @IBOutlet weak var noDataErrorContainer: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()

        acceptedTableView.isHidden = true
        activeLoader.startAnimating()
        noDataErrorContainer.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(errorAlert), name: NSNotification.Name("ErrorConnections"), object: nil)
        loadAcceptedData()
    }
    
    @objc func errorAlert(){
        let alert = UIAlertController(title: "Error!", message: Service.errorConnection, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        activeLoader.isHidden = true
        acceptedTableView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    
    func loadAcceptedData()  {
        if let  apiToken  = Helper.getApiToken() {
        Service.getServiceWithAuth(url: URLs.getAppoiments) {
            (response) in
            print(response)
            let json = JSON(response)
            let result = json["Accepted"]
            if !(result.isEmpty){
            var iDNotNull = true
            var index = 0
            while iDNotNull {
                let startUp_ID = result[index]["id"].string
                let startUp_Name = result[index]["title"].string
                let startUp_RankNo = result[index]["rankNo"].string

                let startUp_Appoimentstatus = result[index]["appoimentstatus"].string
                let startUp_AppoimentTime = result[index]["AppoimentTime"].string
                let startUp_ImageUrl = result[index]["imageURl"].string
                let startUp_About = result[index]["about"].string
                let startUp_ContectInforamtion = result[index]["ContectInforamtion"].dictionaryObject
                let startUp_Email = result[index]["ContectInforamtion"]["Email"].string
                let startUp_Linkedin = result[index]["ContectInforamtion"]["linkedin"].string
                let startUp_Phone = result[index]["ContectInforamtion"]["phone"].string
                
                let contect = ["Email": "","linkedin": "","phone": ""]
                if startUp_ID == nil || startUp_ID?.trimmed == "" || startUp_ID == "null" || startUp_ID == "nil" {
                    iDNotNull = false
                    break
                }
                self.acceptedList.append(StartUpsData(StartupName: startUp_Name ?? "name", StartupID: startUp_ID ?? "ID", StartupImageURL: startUp_ImageUrl ?? "Image", StartUpAbout: startUp_About ?? "about", AppoimentStatus: startUp_Appoimentstatus ?? "Appointmentstatus", AppoimentTime: startUp_AppoimentTime ?? "AppoimentTime", ContectInforamtion: startUp_ContectInforamtion ?? contect, StartupOrder: startUp_RankNo ?? ""))
                index = index + 1
                self.acceptedTableView.reloadData()
                self.activeLoader.isHidden = true
                self.activeLoader.stopAnimating()
                self.acceptedTableView.isHidden = false
                self.noDataErrorContainer.isHidden = true
            }
            }  else {
                self.noDataErrorContainer.isHidden = false

                let alert = UIAlertController(title: "No Accepted found!", message: "No Accepted Appointment till now", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.activeLoader.isHidden = true

            }
        }
    }else {
    self.activeLoader.isHidden = true
    self.acceptedTableView.isHidden = true
    //  print(error.localizedDescription)
    let alert = UIAlertController(title: "Error", message: "You must sign in to Show this Part", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
    
    }
}
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acceptedList.count

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "acceptedcell") as! AcceptedCell
        cell.setStartupCell(startupsList: acceptedList[indexPath.row])
        return cell
    }
    
    @IBAction func btnCancelAppointment(_ sender: Any) {
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to:self.acceptedTableView)
        let indexPath = self.acceptedTableView.indexPathForRow(at: buttonPosition)
        acceptedList.remove(at: (indexPath?.row)!)
        acceptedTableView.reloadData()
     
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        performSegue(withIdentifier: "acceptedstartup", sender: acceptedList[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dis = segue.destination as? StartupDetailsVC {
            if let favDetail = sender as? StartUpsData {
                dis.singleItem = favDetail
            }
        }
    }
    
}

extension AcceptedVC : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Accepted")
    }
}

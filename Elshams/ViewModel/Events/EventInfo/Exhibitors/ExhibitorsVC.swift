//
//  ExhibitorsVC.swift
//  Elshams
//
//  Created by mac on 2/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import AlamofireImage
import Alamofire
import SwiftyJSON

class ExhibitorsVC: BaseViewController , UITableViewDelegate , UITableViewDataSource {
    
    var startUpList = Array<StartUpsData>()
    @IBOutlet weak var startupTableView: UITableView!
    var availableAppointmentList = Array<AvailableAppointment>()
    
    @IBOutlet weak var activeLoader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if MenuViewController.startupEventOrMenu == true {
            addSlideMenuButton()
            //  btnRightBar()
            self.navigationItem.title = "Startups"
            MenuViewController.startupEventOrMenu = false
        }
        startupTableView.isHidden = true
        activeLoader.startAnimating()
        loadAllStartUpData()
    }
    
    func loadAllStartUpData()  {
        if let  apiToken  = Helper.getApiToken() {
            
            Service.getServiceWithAuth(url: URLs.getAllStartups) { //WithAuth
                (response) in
                print(response)
                let json = JSON(response)
                let result = json["AllStartups"]
                var iDNotNull = true
                var index = 0
                while iDNotNull {
                    let startUp_ID = result[index]["id"].string
                    let startUp_Name = result[index]["startupName"].string
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
                    if startUp_ID == nil || startUp_ID?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || startUp_ID == "null" || startUp_ID == "nil" {
                        iDNotNull = false
                        break
                    }
                    self.startUpList.append(StartUpsData(StartupName: startUp_Name ?? "name", StartupID: startUp_ID ?? "ID", StartupImageURL: startUp_ImageUrl ?? "Image", StartUpAbout: startUp_About ?? "about", AppoimentStatus: startUp_Appoimentstatus ?? "Appointmentstatus", AppoimentTime: startUp_AppoimentTime ?? "AppoimentTime", ContectInforamtion: startUp_ContectInforamtion ?? contect))
                    index = index + 1
                    self.startupTableView.reloadData()
                    self.activeLoader.isHidden = true
                    self.activeLoader.stopAnimating()
                    self.startupTableView.isHidden = false
                }
                //  print((self.networkList[2].name)!)
            }
        } else {
            Service.getService(url: URLs.getAllStartups) { //WithAuth
                (response) in
                print(response)
                let json = JSON(response)
                let result = json["AllStartups"]
                var iDNotNull = true
                var index = 0
                while iDNotNull {
                    let startUp_ID = result[index]["id"].string
                    let startUp_Name = result[index]["startupName"].string
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
                    if startUp_ID == nil || startUp_ID?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || startUp_ID == "null" || startUp_ID == "nil" {
                        iDNotNull = false
                        break
                    }
                    self.startUpList.append(StartUpsData(StartupName: startUp_Name ?? "name", StartupID: startUp_ID ?? "ID", StartupImageURL: startUp_ImageUrl ?? "Image", StartUpAbout: startUp_About ?? "about", AppoimentStatus: startUp_Appoimentstatus ?? "Appointmentstatus", AppoimentTime: startUp_AppoimentTime ?? "AppoimentTime", ContectInforamtion: startUp_ContectInforamtion ?? contect))
                    index = index + 1
                    self.startupTableView.reloadData()
                    self.activeLoader.isHidden = true
                    self.activeLoader.stopAnimating()
                    self.startupTableView.isHidden = false
                }
                //  print((self.networkList[2].name)!)
            }
            
        }
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
        var indexPath = self.startupTableView.indexPathForRow(at: buttonPosition)
        //  StartupDetailsVC.sechadualeBTNSend = true
        let startUpId = (startUpList[indexPath!.row].startup_id)!
        print(startUpId)
        Service.getServiceWithAuth(url: "\(URLs.getAvaliableAppoiments)/\(startUpId)") {
            (response) in
            print("this is SessionDetails ")
            print(response)
            let result = JSON(response)
            var iDNotNull = true
            var index = 0
            var availableAppointmentListCount = 0
            
            while iDNotNull {
                let avaAppointment_ID = result[index]["appoimentID"].string
                
                if avaAppointment_ID == nil || avaAppointment_ID?.trimmed == "" ||
                    avaAppointment_ID == "null" || avaAppointment_ID == "nil"{
                    iDNotNull = false
                    // self.popUpViewMethod()
                    break
                }
                let avaAppointment = result[index].dictionaryObject
                let avaAppointment_Name = result[index]["appoimentName"].string
                
                let avaAppointmentOptinal = ["appoimentName": "",
                                             "appoimentID": ""]
                self.availableAppointmentList.append(AvailableAppointment(AvailableAppointmentDict: avaAppointment ?? avaAppointmentOptinal, AppoimentName: avaAppointment_Name ?? "name", AppoimentID: avaAppointment_ID ?? "id"))
                index = index + 1
                availableAppointmentListCount = self.availableAppointmentList.count
                
            }
            if  availableAppointmentListCount != 0 {
                StartupDetailsVC.sechadualeBTNSend = true
                
                self.performSegue(withIdentifier: "exhibitorsdetail", sender: self.startUpList[indexPath!.row])
                
            } else {
                let alert = UIAlertController(title: "Error!", message: "There's no Available Appointments", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return startUpList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exhibitorscell", for: indexPath) as! ExhibitorsCell
        cell.setExibitorsListCell(exibitorsList: startUpList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "exhibitorsdetail", sender: startUpList[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dis = segue.destination as? StartupDetailsVC {
            if let favDetail = sender as? StartUpsData {
                dis.singleItem = favDetail
            }
        }
    }
    
}

// off now so don't link it to container yet
extension ExhibitorsVC : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Exhibitors")
    }
    
}


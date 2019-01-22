//
//  SponsersVC.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import AlamofireImage
import Alamofire
import SwiftyJSON

class SponsersVC: BaseViewController , UITableViewDelegate , UITableViewDataSource , UICollectionViewDelegate , UICollectionViewDataSource{  
    
    @IBOutlet weak var activeLoader: UIActivityIndicatorView!
    @IBOutlet weak var sponserTableView: UITableView!
    @IBOutlet weak var sponserCollectionView: UICollectionView!
    var sponserList = Array<Sponsers>()
    override func viewDidLoad() {
        super.viewDidLoad()
        if MenuViewController.sponserEventOrMenu == true {
            addSlideMenuButton()
           // btnRightBar()
            self.navigationItem.title = "Sponsers"
            MenuViewController.sponserEventOrMenu = false
        }
    
        activeLoader.startAnimating()
        sponserTableView.isHidden = true
        sponserCollectionView.isHidden = true
        loadAllSponserData()
     //   self.navigationItem.bar

    }
    
    func loadAllSponserData()  {
        Service.getService(url: "http://66.226.74.85:4002/api/Event/getNetwork") {
            (response) in
            print(response)
            
            let json = JSON(response)
            let result = json["AllSponsers"]

            var iDNotNull = true
            var index = 0
            while iDNotNull {
                let sponser_ID = result[index]["ID"].string
                let sponser_Name = result[index]["name"].string
                let sponser_Address = result[index]["address"].string
                let sponser_ImageUrl = result[index]["imageUrl"].string
                let sponser_About = result[index]["about"].string
                let sponser_ContectInforamtion = result[index]["ContectInforamtion"].dictionaryObject

                let sponser_Email = result[index]["ContectInforamtion"]["Email"].string
                let sponser_Linkedin = result[index]["ContectInforamtion"]["linkedin"].string
                let sponser_Phone = result[index]["ContectInforamtion"]["phone"].string
                
                let sponser_Sponsertype = result[index]["Sponsertype"].dictionaryObject
                let sponser_Sponsertype_ID = result[index]["Sponsertype"]["id"].string
                let sponser_Sponsertype_name = result[index]["Sponsertype"]["name"].string
                let sponser_Sponsertype_icon = result[index]["Sponsertype"]["icon"].string
                let sponser_Sponsertype_Color = result[index]["Sponsertype"]["color"].string
                
                let contectOptionNil = ["Email": "",
                               "linkedin": "",
                               "phone": ""]
                let sponserTypeOptionNil = ["id": "Media Partner",
                "name": "Media Partner",
                "icon": "",
                "color": "#053a8e"]

                if sponser_ID == nil || sponser_ID?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || sponser_ID == "null" || sponser_ID == "nil" {
                    iDNotNull = false
                    break
                }
                self.sponserList.append(Sponsers(SponserName: sponser_Name ?? "name", SponserAddress: sponser_Address ?? "address", SponserImageURL: sponser_ImageUrl ?? "Image", SponserAbout: sponser_About ?? "ABout", SponserID: sponser_ID ?? "ID", ContectInforamtion: sponser_ContectInforamtion ?? contectOptionNil, Sponsertype: sponser_Sponsertype ?? sponserTypeOptionNil))
                index = index + 1
                self.sponserTableView.reloadData()
                self.sponserCollectionView.reloadData()
                self.activeLoader.isHidden = true
                self.activeLoader.stopAnimating()
                self.sponserTableView.isHidden = false
            }
            //  print((self.networkList[2].name)!)
        }    }
    
    
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
    
    //collection view methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sponserList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sponsercolview", for: indexPath) as! SponserCollectionViewCell
        cell.setSponserColCell(sponserList:  sponserList[indexPath.row])
        return cell
    }
    
    
    //tableview methods

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sponserList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sponsercell") as! SponsersCell
        cell.setSponserCell(sponsersList: sponserList[indexPath.row])
        return cell
    }
    
    @IBAction func changeViewStyle(_ sender: Any) {
        sponserCollectionView.isHidden = false
        sponserTableView.isHidden = true
    }
    
    @IBAction func changeListStyle(_ sender: Any) {
        sponserCollectionView.isHidden = true
        sponserTableView.isHidden = false
    }
    
}

extension SponsersVC : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Sponsers")
    }
}

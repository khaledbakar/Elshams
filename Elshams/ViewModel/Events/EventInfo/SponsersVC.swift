//
//  SponsersVC.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SponsersVC: BaseViewController , UITableViewDelegate , UITableViewDataSource , UICollectionViewDelegate , UICollectionViewDataSource{  
    
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
        sponserList.append(Sponsers(SponserName: "MedGram", SponserAddress: "Obour Bulidings", SponserImage: "avatar", SponsersponserRank: "Gold"))
        sponserList.append(Sponsers(SponserName: "MedGram2", SponserAddress: "Obour Bulidings2", SponserImage: "avatar", SponsersponserRank: "Diamond"))
        sponserCollectionView.isHidden = true
     //   self.navigationItem.bar

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

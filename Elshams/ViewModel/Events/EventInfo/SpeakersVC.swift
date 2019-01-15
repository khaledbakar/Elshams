//
//  SpeakersVC.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SpeakersVC: BaseViewController , UITableViewDataSource , UITableViewDelegate , UICollectionViewDelegate , UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var speakerTableView: UITableView!
    @IBOutlet weak var speakerCollectionView: UICollectionView!
    
    var speakerList = Array<Speakers>()
    override func viewDidLoad() {
        super.viewDidLoad()
        if MenuViewController.speakerEventOrMenu == true {
            addSlideMenuButton()
       //     btnRightBar()
            self.navigationItem.title = "Speakers"
            MenuViewController.speakerEventOrMenu = false
        }
        speakerList.append(Speakers(SpeakerName: "Khaled bakar", JobTitle: "Programmer", jobDescribition: "IOSDeveloper", SpImage: "profile1", FacebookInLink: "facebook.com/khaledbakar.12", Phone: "01060136503", Mail: "kzaky@ikdynamics.com", About: "one of the most importanat people in the life he hasn't title job his name is a title", Website: "www.khaledbakar.com"))
          speakerList.append(Speakers(SpeakerName: "Khaled bakar", JobTitle: "Programmer", jobDescribition: "IOSDeveloper", SpImage: "profile2", FacebookInLink: "facebook.com/khaledbakar.12", Phone: "01060136503", Mail: "kzaky@ikdynamics.com", About: "one of the most importanat people in the life he hasn't title job his name is a title", Website: "www.google.com"))
        speakerList.append(Speakers(SpeakerName: "saad hamo", JobTitle: "Programmer", jobDescribition: "IOSDeveloper", SpImage: "avatar", FacebookInLink: "facebook.com/khaledbakar.12", Phone: "01060136503", Mail: "kzaky@ikdynamics.com", About: "one of the most importanat people in the life he hasn't title job his name is a title", Website: "https://www.facebook.com"))
        speakerCollectionView.isHidden = true

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
        return speakerList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "speakercolview", for: indexPath) as! SpeakerCollectionViewCell
        cell.setSpeakerColCell(speakerList: speakerList[indexPath.row])
        return cell
    }
    
    //tableview methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speakerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "speakercell") as! SpeakersCell
        cell.setSpeakerCell(speakerList: speakerList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "speakersprofile", sender: speakerList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dis = segue.destination as? SpeakerProfileVC {
            if let favDetail = sender as? Speakers {
                dis.singleItem = favDetail
            }
        }
    }
    
    @IBAction func changeViewStyle(_ sender: Any) {
            speakerCollectionView.isHidden = false
            speakerTableView.isHidden = true
    }
    
    @IBAction func changeListStyle(_ sender: Any) {
            speakerCollectionView.isHidden = true
            speakerTableView.isHidden = false
    }
    
}
extension SpeakersVC : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Speakers")
    }
}

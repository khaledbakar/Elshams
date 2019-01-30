//
//  SpeakersVC.swift
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

class SpeakersVC: BaseViewController , UITableViewDataSource , UITableViewDelegate , UICollectionViewDelegate , UICollectionViewDataSource {
    
    
    @IBOutlet weak var activeLoader: UIActivityIndicatorView!
    
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
        activeLoader.startAnimating()
        speakerTableView.isHidden = true
        speakerCollectionView.isHidden = true
        loadAllSpeakerData()

    }
    
    func loadAllSpeakerData()  {
        Service.getService(url: URLs.getAllSpeaker) {
            (response) in
            
            print(response)
            let json = JSON(response)
            let result = json["AllSpeaker"]
            var iDNotNull = true
            var index = 0
            while iDNotNull {
                let speaker_ID = result[index]["ID"].string
                let speaker_Name = result[index]["name"].string
                let speaker_JobTitle = result[index]["jobTitle"].string
                let speaker_CompanyName = result[index]["companyName"].string
                let speaker_ImageUrl = result[index]["imageUrl"].string
                let speaker_About = result[index]["about"].string
                let speaker_ContectInforamtion = result[index]["ContectInforamtion"].dictionaryObject
                let speaker_Email = result[index]["ContectInforamtion"]["Email"].string
                let speaker_Linkedin = result[index]["ContectInforamtion"]["linkedin"].string
                let speaker_Phone = result[index]["ContectInforamtion"]["phone"].string

                let contect = ["Email": "",
                               "linkedin": "",
                               "phone": ""]
                if speaker_ID == nil || speaker_ID?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || speaker_ID == "null" || speaker_ID == "nil" {
                    iDNotNull = false
                    break
                }
                self.speakerList.append(Speakers(SpeakerName: speaker_Name ?? "name", JobTitle: speaker_JobTitle ?? "JOB", CompanyName: speaker_CompanyName ?? "Company", SpImageUrl: speaker_ImageUrl ?? "Image", Speaker_id: speaker_ID ?? "ID", ContectInforamtion: speaker_ContectInforamtion ?? contect, About: speaker_About ?? "About"))
                index = index + 1
                self.speakerTableView.reloadData()
                self.speakerCollectionView.reloadData()
                self.activeLoader.isHidden = true
                self.activeLoader.stopAnimating()
                self.speakerTableView.isHidden = false
            }
            //  print((self.networkList[2].name)!)
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

//
//  SpeakersVC.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip
//import AlamofireImage
import Alamofire
import SwiftyJSON
import SafariServices


class SpeakersVC: BaseViewController , UITableViewDataSource , UITableViewDelegate , UICollectionViewDelegate , UICollectionViewDataSource {
    
    @IBOutlet weak var noDataErrorContainer: UIView!

    @IBOutlet weak var activeLoader: UIActivityIndicatorView!
    
    @IBOutlet weak var shapeContainerView: UIView!
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
        shapeContainerView.isHidden = true
        activeLoader.startAnimating()
        speakerTableView.isHidden = true
        speakerCollectionView.isHidden = true
        noDataErrorContainer.isHidden = true

          NotificationCenter.default.addObserver(self, selector: #selector(errorAlert), name: NSNotification.Name("ErrorConnections"), object: nil)
        loadAllSpeakerData()

    }
    
    @objc func errorAlert(){
        
        let alert = UIAlertController(title: "Error!", message: Service.errorConnection, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        //   reloadBtnShow.isHidden = false
        //  reloadConnection.isHidden = false
        speakerCollectionView.isHidden = true
        activeLoader.isHidden = true
        activeLoader.stopAnimating()
        //reload
    }
    
    func loadAllSpeakerData()  {
        Service.getService(url: URLs.getAllSpeaker) {
            (response) in
            print(response)
            let json = JSON(response)
            let result = json["AllSpeaker"]
            if !(result.isEmpty){
            var iDNotNull = true
            var index = 0
            while iDNotNull {
                let speaker_ID = result[index]["ID"].string
                let speaker_Name = result[index]["name"].string
                let speaker_JobTitle = result[index]["jobTitle"].string
                let speaker_CompanyName = result[index]["companyName"].string
                let speaker_ImageUrl = result[index]["imageUrl"].string
                let speaker_About = result[index]["linkedin"].string // linked in after edit
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
                self.speakerList.append(Speakers(SpeakerName: speaker_Name ?? "", JobTitle: speaker_JobTitle ?? "", CompanyName: speaker_CompanyName ?? "", SpImageUrl: speaker_ImageUrl ?? "", Speaker_id: speaker_ID ?? "", ContectInforamtion: speaker_ContectInforamtion ?? contect, About: speaker_About ?? ""))
                index = index + 1
                self.speakerTableView.reloadData()
                self.speakerCollectionView.reloadData()
                self.activeLoader.isHidden = true
                self.activeLoader.stopAnimating()
                self.speakerTableView.isHidden = true
                self.speakerCollectionView.isHidden = false
                self.noDataErrorContainer.isHidden = true

            }
        }
            else {
                self.noDataErrorContainer.isHidden = false

                let alert = UIAlertController(title: "No Data", message: "No Data found till now", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.activeLoader.isHidden = true
            }
        }
    }
    
    @IBAction func linkedInBtn(_ sender: Any) {
        
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to:self.speakerCollectionView)
        var indexPath = self.speakerCollectionView.indexPathForItem(at: buttonPosition)
        let linkedInSpeaker = speakerList[(indexPath?.row)!]
        let linkedIN = linkedInSpeaker.about
        if linkedIN == nil || linkedIN == "" {
            return
        } else {
       // if (linkedIN?.contains("htttp"))! {
            guard let url = URL(string: (linkedIN!))
                else {
                    return
            }
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
            
            
       // }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // collectionView.deselectRow(at: indexPath, animated: true)

        performSegue(withIdentifier: "speakersprofile", sender: speakerList[indexPath.row])

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "speakercell", for: indexPath) as! SpeakersCell
        cell.setSpeakerCell(speakerList: speakerList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
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

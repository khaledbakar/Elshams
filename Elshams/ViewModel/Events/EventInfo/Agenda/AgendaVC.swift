//
//  AgendaVC.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import AlamofireImage
import SwiftyJSON

class AgendaVC: BaseViewController , UITableViewDataSource , UITableViewDelegate {
    @IBOutlet weak var tableViewAgenda: UITableView!
    @IBOutlet weak var activeLoader: UIActivityIndicatorView!

    @IBOutlet weak var reloadConnection: UIImageView!
    @IBOutlet weak var reloadBtnShow: UIButton!
    // static  var agendaList = Array<ProgramAgendaItems>()
    var agendaSessionList = Array<ProgramAgendaItems>()
    var agendaHeadList = Array<AgendaHeadData>()
    var agendaSpeakerIDImgList = Array<AgendaSpeakerIdPic>()

    var agendaDate = Array<String>()
    var agendaAllDate = Array<String>()

 override func viewDidLoad() {
        super.viewDidLoad()
    
    if MenuViewController.agendaEventOrMenu == true {
        addSlideMenuButton()
       // btnRightBar()
       
        self.navigationItem.title = "Agenda"
        MenuViewController.agendaEventOrMenu = false
    }
    tableViewAgenda.isHidden = true
    activeLoader.startAnimating()
    reloadBtnShow.isHidden = true
    reloadConnection.isHidden = true
    loadTableData()
    if TimeLineHomeVC.failMessage ==  "fail"
    {
        reloadBtnShow.isHidden = false
        reloadConnection.isHidden = false
        self.activeLoader.isHidden = true
       // self.activeLoader.stopAnimating()
        self.tableViewAgenda.isHidden = true
        let alert = UIAlertController(title: "Error", message: "No internet connection please turn on it", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
   
  /*  var secCount = 0
  //  for index in 0..<AgendaVC.agendaSessionList.count {
      for index in 0..<agendaSessionList.count {

        agendaDate.append("\((agendaSessionList[index].agendaDate)!)")
        if (agendaAllDate.contains((agendaSessionList[index].agendaDate)!)) {
            
            secCount = secCount + 1
            continue
        } else {
            agendaAllDate.append((agendaSessionList[index].agendaDate)!)
            secCount = 1
        }
    }
    
    for indFilter in 0..<agendaAllDate.count {
        let filter = agendaDate.filter { $0.contains(agendaAllDate[indFilter]) }
        
    }
 */
    }
    
    @IBAction func reloadDataConnection(_ sender: Any) {
        tableViewAgenda.isHidden = true
        activeLoader.isHidden = true
        activeLoader.startAnimating()
        reloadBtnShow.isHidden = true
        reloadConnection.isHidden = true
        loadTableData()
    }
    
    func loadTableData()  {
        if let  apiToken  = Helper.getApiToken() {

        Service.getServiceWithAuth(url: URLs.getAgenda) {
            (response) in
            print(response)
            let result = JSON(response)
            
            var iDNotNull = true
            var index = 0
            while iDNotNull {
                let agenda_Type = result[index]["type"].string

                 if agenda_Type == nil || agenda_Type?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                  agenda_Type == "null"{
                    iDNotNull = false
                    break
                 }
                let agenda_ID = result[index]["Id"].string
                let agenda_rondomColor = result[index]["rondomColor"].string
                let agenda_date = result[index]["date"].string
                let agenda_sessionTitle = result[index]["sessionTitle"].string
                let agenda_dateTitle = result[index]["title"].string
                let agenda_Speakers = result[index]["speakers"]//dictionaryObject
                let agenda_SpeakersDict = result[index]["speakers"].dictionaryObject//dictionaryObject

                var SpeakeriDNotNull = true
                var indexSpeaker = 0

                while SpeakeriDNotNull {
                    let agenda_speaker_id = agenda_Speakers[indexSpeaker]["ID"].string
                    
                    if agenda_speaker_id == nil || agenda_speaker_id?.trimmed == "" ||
                        agenda_speaker_id == "null"{
                        SpeakeriDNotNull = false
                        break
                    }
                    let agenda_speaker_url = agenda_Speakers[indexSpeaker]["imageUrl"].string
                    self.agendaSpeakerIDImgList.append(AgendaSpeakerIdPic(SpImageUrl: agenda_speaker_url ?? "", Speaker_id: agenda_speaker_id ?? ""))
                    indexSpeaker = indexSpeaker + 1
                }
                let agenda_Time = result[index]["time"].string
                let agenda_SessionLocation = result[index]["location"].string
                let agenda_isFavourate = result[index]["isFavourate"].bool
                let agenda_IsFavourate_String = "\(agenda_isFavourate)"
                
                if agenda_Type == "head" {
                    self.agendaHeadList.append(AgendaHeadData(HeadTitle: agenda_dateTitle ?? "title", HeadDate: agenda_date ?? "date", HeadType: agenda_Type ?? "type"))
                }
                else if agenda_Type == "session" {
                    self.agendaSessionList.append(ProgramAgendaItems(Agenda_ID: agenda_ID!, SessionTitle: agenda_sessionTitle ?? "Title", SessionTime: agenda_Time ?? "Time", SessionLocation: agenda_SessionLocation ?? "location", SpeakersSession: agenda_SpeakersDict ?? ["ID" : "314",
                                                                                                                                                                                                                                                "imageUrl" : "http:-b01d-582382a5795e.jpg"]
                        , AgendaDate: agenda_date ?? "date", FavouriteSession: agenda_isFavourate ?? true , FavouriteSessionStr: agenda_IsFavourate_String , RondomColor: agenda_rondomColor ?? "red", AgendaType: agenda_Type ?? "session", SpeakersIdImg: self.agendaSpeakerIDImgList))
                }
                
                index = index + 1
                self.agendaSpeakerIDImgList.removeAll()
                self.tableViewAgenda.reloadData()
                self.activeLoader.isHidden = true
                self.activeLoader.stopAnimating()
                self.tableViewAgenda.isHidden = false
            }
        }
        } else {
            Service.getService(url: URLs.getAgenda) {
                (response) in
                print(response)
                let result = JSON(response)
                
                var iDNotNull = true
                var index = 0
                while iDNotNull {
                    let agenda_Type = result[index]["type"].string
                    
                    if agenda_Type == nil || agenda_Type?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                        agenda_Type == "null"{
                        iDNotNull = false
                        break
                    }
                    let agenda_ID = result[index]["Id"].string
                    let agenda_rondomColor = result[index]["rondomColor"].string
                    let agenda_date = result[index]["date"].string
                    let agenda_sessionTitle = result[index]["sessionTitle"].string
                    let agenda_dateTitle = result[index]["title"].string
                    let agenda_Speakers = result[index]["speakers"]
                    let agenda_SpeakersDict = result[index]["speakers"].dictionaryObject
                    var SpeakeriDNotNull = true
                    var indexSpeaker = 0
                    
                    while SpeakeriDNotNull {
                        let agenda_speaker_id = agenda_Speakers[indexSpeaker]["ID"].string
                        
                        if agenda_speaker_id == nil || agenda_speaker_id?.trimmed == "" ||
                            agenda_speaker_id == "null"{
                            SpeakeriDNotNull = false
                            break
                        }
                        let agenda_speaker_url = agenda_Speakers[indexSpeaker]["imageUrl"].string
                        self.agendaSpeakerIDImgList.append(AgendaSpeakerIdPic(SpImageUrl: agenda_speaker_url ?? "", Speaker_id: agenda_speaker_id ?? ""))
                        indexSpeaker = indexSpeaker + 1
                    }
                    let agenda_Time = result[index]["time"].string
                    let agenda_SessionLocation = result[index]["location"].string
                    let agenda_isFavourate = result[index]["isFavourate"].bool
                    let agenda_IsFavourate_String = "\(agenda_isFavourate)"
                    
                    if agenda_Type == "head" {
                        self.agendaHeadList.append(AgendaHeadData(HeadTitle: agenda_dateTitle ?? "title", HeadDate: agenda_date ?? "date", HeadType: agenda_Type ?? "type"))
                    }
                    else if agenda_Type == "session" {
                        self.agendaSessionList.append(ProgramAgendaItems(Agenda_ID: agenda_ID!, SessionTitle: agenda_sessionTitle ?? "Title", SessionTime: agenda_Time ?? "Time", SessionLocation: agenda_SessionLocation ?? "location", SpeakersSession: agenda_SpeakersDict ?? [
                            "ID" : "314",
                            "imageUrl" : "http:-b01d-582382a5795e.jpg"]
                            , AgendaDate: agenda_date ?? "date", FavouriteSession: agenda_isFavourate ?? true , FavouriteSessionStr: agenda_IsFavourate_String , RondomColor: agenda_rondomColor ?? "red", AgendaType: agenda_Type ?? "session", SpeakersIdImg: self.agendaSpeakerIDImgList))
                    }
                    index = index + 1
                    self.agendaSpeakerIDImgList.removeAll()
                    self.tableViewAgenda.reloadData()
                    self.activeLoader.isHidden = true
                    self.activeLoader.stopAnimating()
                    self.tableViewAgenda.isHidden = false
                }
            }
        }
    }
    func btnRightBar()  {
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
    func numberOfSections(in tableView: UITableView) -> Int {
      //  return agendaAllDate.count
        return agendaHeadList.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // return  agendaAllDate[section]
        return agendaHeadList[section].headTitle
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.seemGray
        headerView.frame.size.height = 60
        let headerLabel = UILabel(frame: CGRect(x: 30, y: 25, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 13)
        headerLabel.textColor = UIColor.seemDrakGray
        headerLabel.text = self.tableView(self.tableViewAgenda, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        return headerView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
       var counter = 1
        for i in 0..<agendaHeadList.count {
            if section == i  {
                let filter = agendaSessionList.filter { (($0.agendaDate?.contains(agendaHeadList[i].headDate as! String))!) }
                print(filter.count)
                counter = filter.count
                break
            }
            else {
                continue
            }
        }
         return counter
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "agendacell") as! AgendaCell
 
        for i in 0..<agendaHeadList.count {
            if indexPath.section == i {
               let filt = agendaSessionList.filter { (($0.agendaDate?.contains(agendaHeadList[i].headDate as! String))!) } //{ ($0.agendaDate?.contains(agendaAllDate[i]))! }
                cell.setAgendaCell(AgendaProgram: filt[indexPath.row], IndexPath: indexPath.row)
                break
            }
            else {
                continue
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        OpenSessionVC.AgednaOrFavourite = true
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "opensession", sender: agendaSessionList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dis = segue.destination as? OpenSessionVC {
            if let favDetail = sender as? ProgramAgendaItems {
                dis.singleItem = favDetail
            }
        }
    }
    
}

extension AgendaVC : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Agenda")
}
}


/*   if network_Name == nil || network_Name?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
 if agenda_type == "head"{
 agendaDateGr
 }*/

/*    self.agendaList.append(ProgramAgendaItems(ProgramName: <#T##String#>, StartTime: <#T##String#>, EndTime: <#T##String#>, ProgLocation: <#T##String#>, SpImageOne: <#T##String#>, SpImageTwo: <#T##String#>, AgendaDate: <#T##String#>, FavouriteSession: <#T##Bool#>, FavouriteSessionStr: <#T##String#>, Describtion: <#T##String#>, Speaker_FK_Id: <#T##Int#>, Speaker_FK_Id_Str: <#T##String#>))
 */
/*  network_Name == "null" {
 iDNotNull = false
 break
 } */

//number of row in section
/* var counter = 1
 for i in 1..<agendaAllDate.count + 1{
 if section == i - 1 {
 let filter = agendaDate.filter { $0.contains(agendaAllDate[i - 1]) }
 print(filter.count)
 counter = filter.count
 break
 }
 else {
 continue
 }
 }
 return counter */


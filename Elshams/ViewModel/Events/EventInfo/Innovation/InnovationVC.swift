//
//  InnovationVC.swift
//  Elshams
//
//  Created by mac on 2/16/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON

class InnovationVC: BaseViewController , UITableViewDelegate , UITableViewDataSource {

    var innovationList = Array<StartUpsData>()
    @IBOutlet weak var innovationTableView: UITableView!
    @IBOutlet weak var activeLoader: UIActivityIndicatorView!
    @IBOutlet weak var noDataErrorContainer: UIView!
    
    @IBOutlet weak var reloadConnection: UIImageView!
    @IBOutlet weak var reloadBtnShow: UIButton!
    // static  var agendaList = Array<ProgramAgendaItems>()
    var innovationSessionList = Array<ProgramAgendaItems>()
    var innovationHeadList = Array<AgendaHeadData>()
    var innovationSpeakerIDImgList = Array<AgendaSpeakerIdPic>()
    
    var innovationDate = Array<String>()
    var innovationAllDate = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        //  btnRightBar()
        self.navigationItem.title = "Innovation"
        innovationTableView.isHidden = true
        activeLoader.startAnimating()
        reloadBtnShow.isHidden = true
        reloadConnection.isHidden = true
        noDataErrorContainer.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(errorAlert), name: NSNotification.Name("ErrorConnections"), object: nil)
        loadInnovationData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    
    @objc func errorAlert(){
        
        let alert = UIAlertController(title: "Error!", message: Service.errorConnection, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        reloadBtnShow.isHidden = false
        reloadConnection.isHidden = false
        innovationTableView.isHidden = true
        activeLoader.isHidden = true
        activeLoader.stopAnimating()
        //reload
    }
    
    @IBAction func reloadDataConnection(_ sender: Any) {
        innovationTableView.isHidden = true
        activeLoader.isHidden = true
        activeLoader.startAnimating()
        reloadBtnShow.isHidden = true
        reloadConnection.isHidden = true
        innovationSessionList.removeAll()
        innovationHeadList.removeAll()
        loadInnovationData()
    }
    
    func loadInnovationData()  {
        if let  apiToken  = Helper.getApiToken() {
            Service.getServiceWithAuth(url: URLs.getInnovation) {
                (response) in
                print(response)
                let result = JSON(response)
                if !(result.isEmpty){
                    
                    var iDNotNull = true
                    var index = 0
                    while iDNotNull {
                        let innovation_Type = result[index]["type"].string
                        
                        if innovation_Type == nil || innovation_Type?.trimmed == "" ||
                            innovation_Type == "null"{
                            iDNotNull = false
                            break
                        }
                        
                        let innovation_ID = result[index]["Id"].string
                        let innovation_rondomColor = result[index]["rondomColor"].string
                        let innovation_date = result[index]["date"].string
                        let innovation_sessionTitle = result[index]["sessionTitle"].string
                        let innovation_dateTitle = result[index]["title"].string
                        let innovation_Speakers = result[index]["speakers"]//dictionaryObject
                        let innovation_SpeakersDict = result[index]["speakers"].dictionaryObject//dictionaryObject
                        
                        var SpeakeriDNotNull = true
                        var indexSpeaker = 0
                        
                        while SpeakeriDNotNull {
                            let innovation_speaker_id = innovation_Speakers[indexSpeaker]["ID"].string
                            
                            if innovation_speaker_id == nil || innovation_speaker_id?.trimmed == "" ||
                                innovation_speaker_id == "null"{
                                SpeakeriDNotNull = false
                                break
                            }
                            let innovation_speaker_url = innovation_Speakers[indexSpeaker]["imageUrl"].string
                            self.innovationSpeakerIDImgList.append(AgendaSpeakerIdPic(SpImageUrl: innovation_speaker_url ?? "", Speaker_id: innovation_speaker_id ?? ""))
                            indexSpeaker = indexSpeaker + 1
                        }
                        let innovation_Time = result[index]["time"].string
                        let innovation_SessionLocation = result[index]["location"].string
                        let innovation_isFavourate = result[index]["isFavourate"].bool
                        let innovation_IsFavourate_String = "\(innovation_isFavourate)"
                        
                        if innovation_Type == "head" {
                            self.innovationHeadList.append(AgendaHeadData(HeadTitle: innovation_dateTitle ?? "", HeadDate: innovation_date ?? "", HeadType: innovation_Type ?? ""))
                        }
                        else if innovation_Type == "session" {
                            self.innovationSessionList.append(ProgramAgendaItems(Agenda_ID: innovation_ID!, SessionTitle: innovation_sessionTitle ?? "", SessionTime: innovation_Time ?? "", SessionLocation: innovation_SessionLocation ?? "", SpeakersSession: innovation_SpeakersDict ?? ["ID" : "314",
                                                                                                                                                                                                                                                                                      "imageUrl" : "http:-b01d-582382a5795e.jpg"]
                                , AgendaDate: innovation_date ?? "", FavouriteSession: innovation_isFavourate ?? true , FavouriteSessionStr: innovation_IsFavourate_String , RondomColor: innovation_rondomColor ?? "red", AgendaType: innovation_Type ?? "session", SpeakersIdImg: self.innovationSpeakerIDImgList))
                        }
                        
                        index = index + 1
                        self.innovationSpeakerIDImgList.removeAll()
                        self.innovationTableView.reloadData()
                        self.activeLoader.isHidden = true
                        self.activeLoader.stopAnimating()
                        self.innovationTableView.isHidden = false
                        self.noDataErrorContainer.isHidden = true
                        
                    }
                }
                    
                else
                {
                    self.noDataErrorContainer.isHidden = false
                    
                    let alert = UIAlertController(title: "No Data", message: "No Data found till now", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.activeLoader.isHidden = true
                }
            }
        } else {
            Service.getService(url: URLs.getAgenda) {
                (response) in
                print(response)
                let result = JSON(response)
                if !(result.isEmpty){
                    
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
                            self.innovationSpeakerIDImgList.append(AgendaSpeakerIdPic(SpImageUrl: agenda_speaker_url ?? "", Speaker_id: agenda_speaker_id ?? ""))
                            indexSpeaker = indexSpeaker + 1
                        }
                        let agenda_Time = result[index]["time"].string
                        let agenda_SessionLocation = result[index]["location"].string
                        let agenda_isFavourate = result[index]["isFavourate"].bool
                        let agenda_IsFavourate_String = "\(agenda_isFavourate)"
                        
                        if agenda_Type == "head" {
                            self.innovationHeadList.append(AgendaHeadData(HeadTitle: agenda_dateTitle ?? "", HeadDate: agenda_date ?? "", HeadType: agenda_Type ?? ""))
                        }
                        else if agenda_Type == "session" {
                            self.innovationSessionList.append(ProgramAgendaItems(Agenda_ID: agenda_ID!, SessionTitle: agenda_sessionTitle ?? "", SessionTime: agenda_Time ?? "", SessionLocation: agenda_SessionLocation ?? "", SpeakersSession: agenda_SpeakersDict ?? [
                                "ID" : "314",
                                "imageUrl" : "http:-b01d-582382a5795e.jpg"]
                                , AgendaDate: agenda_date ?? "date", FavouriteSession: agenda_isFavourate ?? true , FavouriteSessionStr: agenda_IsFavourate_String , RondomColor: agenda_rondomColor ?? "", AgendaType: agenda_Type ?? "", SpeakersIdImg: self.innovationSpeakerIDImgList))
                        }
                        index = index + 1
                        self.innovationSpeakerIDImgList.removeAll()
                        self.innovationTableView.reloadData()
                        self.activeLoader.isHidden = true
                        self.activeLoader.stopAnimating()
                        self.innovationTableView.isHidden = false
                        self.noDataErrorContainer.isHidden = true
                        
                    }
                    
                }
                    // }
                else {
                    self.noDataErrorContainer.isHidden = false
                    
                    let alert = UIAlertController(title: "No Data", message: "No Data found till now", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.activeLoader.isHidden = true
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
        return innovationHeadList.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // return  agendaAllDate[section]
        return innovationHeadList[section].headTitle
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.seemGray
        headerView.frame.size.height = 60
        let headerLabel = UILabel(frame: CGRect(x: 30, y: 25, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 13)
        headerLabel.textColor = UIColor.seemDrakGray
        headerLabel.text = self.tableView(self.innovationTableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        return headerView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var counter = 1
        for i in 0..<innovationHeadList.count {
            if section == i  {
                let filter = innovationSessionList.filter { (($0.agendaDate?.contains(innovationHeadList[i].headDate as! String))!) }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "innovationcell", for: indexPath) as! InnovationCell
        
        for i in 0..<innovationHeadList.count {
            if indexPath.section == i {
                let filt = innovationSessionList.filter { (($0.agendaDate?.contains(innovationHeadList[i].headDate as! String))!) } //{ ($0.agendaDate?.contains(agendaAllDate[i]))! }
                cell.setInnovationCell(AgendaProgram: filt[indexPath.row], IndexPath: indexPath.row)
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
        performSegue(withIdentifier: "innovationdetails", sender: innovationSessionList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dis = segue.destination as? OpenSessionVC {
            if let favDetail = sender as? ProgramAgendaItems {
                dis.singleItem = favDetail
            }
        }
    }

}

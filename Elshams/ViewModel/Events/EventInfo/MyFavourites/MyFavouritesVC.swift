//
//  MyFavouritesVC.swift
//  Elshams
//
//  Created by mac on 12/5/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON

class MyFavouritesVC: BaseViewController , UITableViewDelegate , UITableViewDataSource {
 //   var agendaFavList = Array<ProgramAgendaItems>()
   
    @IBOutlet weak var favourSessionTableView: UITableView!
    @IBOutlet weak var noDataErrorContainer: UIView!

    @IBOutlet weak var activeLoader: UIActivityIndicatorView!
    var agendaDate = Array<String>()
    var agendaAllDate = Array<String>()
  //  var filterFavour = AgendaVC.agendaList.filter { (($0.favouriteSessionStr?.contains("true"))!)}
    var agendaSessionList = Array<ProgramAgendaItems>()
    var agendaHeadList = Array<AgendaHeadData>()
    var agendaSpeakerIDImgList = Array<AgendaSpeakerIdPic>()
    var agendaHeadCount = Array<AgenaHeadCountIndex>()
    var AgendaHeadCounter :Int?


   
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
      //  btnRightBar()
        self.navigationItem.title = "My Favourites"
    
        activeLoader.startAnimating()
        favourSessionTableView.isHidden = true
        noDataErrorContainer.isHidden = true

          NotificationCenter.default.addObserver(self, selector: #selector(errorAlert), name: NSNotification.Name("ErrorConnections"), object: nil)
        loadFavourSessionsData()
        var secCount = 0
      
        
        for indFilter in 0..<agendaAllDate.count {
            let filter = agendaDate.filter { $0.contains(agendaAllDate[indFilter]) }
            
        }
    }
    
    @objc func errorAlert(){
        
        let alert = UIAlertController(title: "Error!", message: Service.errorConnection, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
     //   reloadBtnShow.isHidden = false
      //  reloadConnection.isHidden = false
        favourSessionTableView.isHidden = true
        activeLoader.isHidden = true
        activeLoader.stopAnimating()
        //reload
        
    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
   func loadFavourSessionsData(){
    if let  apiToken  = Helper.getApiToken() {

    Service.getServiceWithAuth(url: URLs.getAllfavourate){
        (response) in
        print(response)
        let result = JSON(response)
        // if auth prop "Message" : "Authorization has been denied for this request."
        if !(result.isEmpty){
        var iDNotNull = true
        var index = 0
        while iDNotNull {
            let agenda_Type = result[index]["type"].string
            if agenda_Type == nil || agenda_Type?.trimmed == "" ||
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
              //  Helper.gette
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
                self.agendaHeadList.append(AgendaHeadData(HeadTitle: agenda_dateTitle ?? "", HeadDate: agenda_date ?? "", HeadType: agenda_Type ?? ""))
                if index != 0 {
                    self.agendaHeadCount.append(AgenaHeadCountIndex(HeadCount: self.AgendaHeadCounter!))
                }
                self.AgendaHeadCounter = 0
            }
            else if agenda_Type == "session" {
                self.AgendaHeadCounter =  self.AgendaHeadCounter!  + 1
                self.agendaSessionList.append(ProgramAgendaItems(Agenda_ID: agenda_ID!, SessionTitle: agenda_sessionTitle ?? "", SessionTime: agenda_Time ?? "", SessionLocation: agenda_SessionLocation ?? "", SpeakersSession: agenda_SpeakersDict ?? ["":""]
                    , AgendaDate: agenda_date ?? "", FavouriteSession: agenda_isFavourate ?? true , FavouriteSessionStr: agenda_IsFavourate_String ?? "" , RondomColor: agenda_rondomColor ?? "", AgendaType: agenda_Type ?? "", SpeakersIdImg: self.agendaSpeakerIDImgList))
                 // ?? [[ "ID" : "314","imageUrl" : "http:-b01d-582382a5795e.jpg"]] as! [[String : Any]]
            }
            index = index + 1
            self.agendaSpeakerIDImgList.removeAll()

            self.favourSessionTableView.reloadData()
            self.activeLoader.isHidden = true
            self.activeLoader.stopAnimating()
            self.favourSessionTableView.isHidden = false
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
    }else {
        self.activeLoader.isHidden = true
        self.favourSessionTableView.isHidden = true
        //  print(error.localizedDescription)
        let alert = UIAlertController(title: "Error", message: "You must sign in to Show this Part", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    
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
        return agendaHeadList.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  agendaHeadList[section].headTitle
    }
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.seemGray
        headerView.frame.size.height = 60
        let headerLabel = UILabel(frame: CGRect(x: 30, y: 25, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 13)
        headerLabel.textColor = UIColor.seemDrakGray
        headerLabel.text = self.tableView(self.favourSessionTableView, titleForHeaderInSection: section)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myfavacell", for: indexPath) as! MyFavouritesCell
        cell.speakerOneImage.image = nil
        cell.speakerTwoImage.image = nil
        cell.cellColor.backgroundColor = nil

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
        OpenSessionVC.AgednaOrFavourite = "MyFavourites"
        tableView.deselectRow(at: indexPath, animated: true)
        for i in 0..<agendaHeadList.count  {
            if indexPath.section == i {
                if indexPath.section == 0{
                    performSegue(withIdentifier: "openfavsession", sender: agendaSessionList[indexPath.row])
                }else {
                    let headCountInt = agendaHeadCount[i - 1].headCount
                    let selectRow = headCountInt! + indexPath.row
                    performSegue(withIdentifier: "openfavsession", sender: agendaSessionList[selectRow])
                }
            }

        // el mafrood ab3t filt
     //  performSegue(withIdentifier: "openfavsession", sender: agendaSessionList[indexPath.row])
    }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dis = segue.destination as? OpenSessionVC {
            if let favDetail = sender as? ProgramAgendaItems {
                dis.singleItem = favDetail
            }
        }
    }
}

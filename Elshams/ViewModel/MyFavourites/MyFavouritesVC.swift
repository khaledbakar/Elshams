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
    
    @IBOutlet weak var activeLoader: UIActivityIndicatorView!
    var agendaDate = Array<String>()
    var agendaAllDate = Array<String>()
  //  var filterFavour = AgendaVC.agendaList.filter { (($0.favouriteSessionStr?.contains("true"))!)}
    var agendaSessionList = Array<ProgramAgendaItems>()
    var agendaHeadList = Array<AgendaHeadData>()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
      //  btnRightBar()
        self.navigationItem.title = "My Favourites"
    
        activeLoader.startAnimating()
        favourSessionTableView.isHidden = true
        loadFavourSessionsData()
        var secCount = 0
      
        
        for indFilter in 0..<agendaAllDate.count {
            let filter = agendaDate.filter { $0.contains(agendaAllDate[indFilter]) }
            
        }
    }
    
   func loadFavourSessionsData(){
    print(URLs.headerAuth)
    Service.getServiceWithAuth(url: URLs.getAllfavourate){
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
            let agenda_Speakers = result[index]["speakers"].dictionaryObject
            let agenda_Time = result[index]["time"].string
            let agenda_SessionLocation = result[index]["location"].string
            let agenda_isFavourate = result[index]["isFavourate"].bool
            let agenda_IsFavourate_String = "\(agenda_isFavourate)"
            
            
            if agenda_Type == "head" {
                self.agendaHeadList.append(AgendaHeadData(HeadTitle: agenda_dateTitle ?? "title", HeadDate: agenda_date ?? "date", HeadType: agenda_Type ?? "type"))
            }
            else if agenda_Type == "session" {
                self.agendaSessionList.append(ProgramAgendaItems(Agenda_ID: agenda_ID!, SessionTitle: agenda_sessionTitle ?? "Title", SessionTime: agenda_Time ?? "Time", SessionLocation: agenda_SessionLocation ?? "location", SpeakersSession: agenda_Speakers ?? [
                    "ID" : "314",
                    "imageUrl" : "http:-b01d-582382a5795e.jpg"]
                    , AgendaDate: agenda_date ?? "date", FavouriteSession: agenda_isFavourate ?? true , FavouriteSessionStr: agenda_IsFavourate_String , RondomColor: agenda_rondomColor ?? "red", AgendaType: agenda_Type ?? "session"))
            }
            
            index = index + 1
            self.favourSessionTableView.reloadData()
            self.activeLoader.isHidden = true
            self.activeLoader.stopAnimating()
            self.favourSessionTableView.isHidden = false
        }
        //  print((self.networkList[2].name)!)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "myfavacell") as! MyFavouritesCell

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
        OpenSessionVC.AgednaOrFavourite = false
        // el mafrood ab3t filt
       performSegue(withIdentifier: "openfavsession", sender: agendaSessionList[indexPath.row])
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

//
//  NotificationsVC.swift
//  Elshams
//
//  Created by mac on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON

class NotificationsVC: BaseViewController , UITableViewDataSource , UITableViewDelegate {
    @IBOutlet weak var notifyTableView: UITableView!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    var notificationList = Array<Notifications>()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        notifyTableView.isHidden = true
        activityLoader.startAnimating()
        loadNotifyData()
      //  btnRightBar()

        self.navigationItem.title = "Notifications"

       // notificationList.append(Notifications(NotificationName: "MEDGRAM", NotificationDetails: "rod 3lya msh 2ader atnfs", NotitficationImageUrl: "avatar"))

    }
    
    func loadNotifyData()  {
        Service.getServiceWithAuth(url: URLs.getAllNotification){
       // Service.getService(url: "http://66.226.74.85:4002/api/Event/getAllNotification") {
            (response) in
            print(response)
            let result = JSON(response)
            var iDNotNull = true
            var index = 0
            while iDNotNull {
                let notification_ID_int = result[index]["id"].int
                let notification_ID = "\(notification_ID_int)"
                if notification_ID == nil || notification_ID.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                    notification_ID == "null" || notification_ID == "nil" {
                    iDNotNull = false
                    break
                }
           
          //  for data in result {
                let notification_Type = result[index]["type"].string
                let notification_Body = result[index]["body"].string
                let notification_ImageURl = result[index]["imageURl"].string
                let notification_title = result[index]["title"].string
                let notification_Status = result[index]["notificationStatus"].string
                self.notificationList.append(Notifications(NotificationTitle: notification_title ?? "title", NotificationID: notification_ID ?? "ID", NotitficationImageUrl: notification_ImageURl ?? "Image", NotificationStatus: notification_Status ?? "status", NotificationType: notification_Type ?? "Type", NotificationBody: notification_Body ?? "Body"))
                //  }
                index = index + 1
            }
                self.notifyTableView.reloadData()
                self.activityLoader.isHidden = true
                self.activityLoader.stopAnimating()
                self.notifyTableView.isHidden = false
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationcell") as! NotificationCell
        cell.setNotificationCell(NotificationList: notificationList[indexPath.row])
        return cell
    }
    
    
}



/*while iDNotNull {
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
 index = index + 1 */

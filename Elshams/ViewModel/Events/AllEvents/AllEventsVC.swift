//
//  AllEventsVC.swift
//  Elshams
//
//  Created by mac on 12/24/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class AllEventsVC: BaseViewController , UITableViewDelegate , UITableViewDataSource {
    var eventsList = Array<EventsData>()

    @IBOutlet weak var allEventTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
      //  btnRightBar()
        self.navigationItem.title = "Events"
        eventsList.append(EventsData(EventsName: "EmaarMasr", EventsAddress: "Cairo,Egypt", EventsDetail: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, ", EventsImage: "avatar"))
        eventsList.append(EventsData(EventsName: "EmaarMasr", EventsAddress: "Cairo,Egypt", EventsDetail: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, ", EventsImage: "avatar"))

    }
    
    func btnRightBar()  {
        let btnSearch = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: nil, action:  #selector(searchTool))
        self.navigationItem.rightBarButtonItem = btnSearch;
    }
    
    @objc func searchTool() {
        print("gooooood")
    }
    
    //tableview methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alleventcell") as! AllEventsCell
        cell.setEventsCell(EventsItemsList: eventsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "eventcollection", sender: eventsList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dis = segue.destination as? EventInfoContainerVC {
            if let favDetail = sender as? EventsData {
                dis.singleItem = favDetail
            }
        }
    }
    
    

}

//
//  MyFavouritesVC.swift
//  Elshams
//
//  Created by mac on 12/5/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class MyFavouritesVC: BaseViewController , UITableViewDelegate , UITableViewDataSource {
    var agendaFavList = Array<ProgramAgendaItems>()
    var agendaFavDateList:[String] = ["Monday,March","Tuesday,March"]


    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
      //  btnRightBar()
        self.navigationItem.title = "My Favourites"
        agendaFavList.append(ProgramAgendaItems(ProgramName: "Regestration and Networking", StartTime: "8AM", EndTime: "10AM", ProgLocation: "hall", SpImageOne: "avatar", SpImageTwo: "avatar",AgendaDate:"Monday,March"))
        agendaFavList.append(ProgramAgendaItems(ProgramName: "Regestration and Networking", StartTime: "11AM", EndTime: "11.30AM", ProgLocation: "cinema", SpImageOne: "avatar", SpImageTwo: "avatar", AgendaDate: "Tuesday,March"))
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
        return 1
    }
   /*    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        return agendaFavDateList[section]
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return agendaFavList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myfavacell") as! MyFavouritesCell
        cell.setAgendaCell(AgendaProgram: agendaFavList[indexPath.row],IndexPath: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        OpenSessionVC.AgednaOrFavourite = false
        performSegue(withIdentifier: "openfavsession", sender: agendaFavList[indexPath.row])
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

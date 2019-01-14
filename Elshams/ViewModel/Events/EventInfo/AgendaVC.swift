//
//  AgendaVC.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class AgendaVC: BaseViewController , UITableViewDataSource , UITableViewDelegate {
    @IBOutlet weak var tableViewAgenda: UITableView!
    
    var agendaList = Array<ProgramAgendaItems>()
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
   
    agendaList.append(ProgramAgendaItems(ProgramName: "Regestration and Networking", StartTime: "8AM", EndTime: "10AM", ProgLocation: "hall", SpImageOne: "avatar", SpImageTwo: "avatar",AgendaDate:"Monday,March 8"))
 agendaList.append(ProgramAgendaItems(ProgramName: "Regestration and Networking", StartTime: "11AM", EndTime: "11.30AM", ProgLocation: "cinema", SpImageOne: "avatar", SpImageTwo: "avatar",AgendaDate:"Monday,March 8"))
    agendaList.append(ProgramAgendaItems(ProgramName: "New Reg", StartTime: "11AM", EndTime: "11.30AM", ProgLocation: "cinema", SpImageOne: "avatar", SpImageTwo: "avatar",AgendaDate:"Monday,March 9"))

    var secCount = 0
    for index in 0..<agendaList.count {
      agendaDate.append("\((agendaList[index].agendaDate)!)")
        if (agendaAllDate.contains((agendaList[index].agendaDate)!)) {
            
            secCount = secCount + 1
            continue
        } else {
            agendaAllDate.append((agendaList[index].agendaDate)!)
            secCount = 1
        }
    }
    
    for indFilter in 0..<agendaAllDate.count {
        let filter = agendaDate.filter { $0.contains(agendaAllDate[indFilter]) }
        
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
        return agendaAllDate.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return  agendaAllDate[section]
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
         return counter
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "agendacell") as! AgendaCell
 
        for i in 0..<agendaAllDate.count {
            if indexPath.section == i {
                let filt = agendaList.filter { ($0.agendaDate?.contains(agendaAllDate[i]))! }
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
        performSegue(withIdentifier: "opensession", sender: agendaList[indexPath.row])
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

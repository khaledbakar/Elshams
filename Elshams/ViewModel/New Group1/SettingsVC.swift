//
//  SettingsVC.swift
//  Elshams
//
//  Created by mac on 12/23/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    var sections = ["Information","Praivacy"]
    var quest = ["Email","Password","Job Title","Phone","Other"]
    var ans =  ["Kzaky@ikdynamics.com","12345","IOS Developer","01060136503","NO"]
    var privacy = ["public"]
    var ansPraivacy = false
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var updateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImg.layer.cornerRadius = profileImg.frame.width / 2
        profileImg.clipsToBounds = true
        if let  apiToken  = Helper.getApiToken() {

        
        }else{
            //view.isHidden = true
            profileImg.isHidden = true
            settingTableView.isHidden = true
            updateBtn.isHidden = true
            let alert = UIAlertController(title: "Error", message: "You must sign in to Show this Part", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
          //  dismiss(animated: true, completion: nil)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return ans.count
        } else {
            return privacy.count
        }
    }
  /*  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.seemGray
        headerView.frame.size.height = 80
        let headerLabel = UILabel(frame: CGRect(x: 30, y: 25, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 13)
        headerLabel.textColor = UIColor.seemDrakGray
        headerLabel.text = self.tableView(self.tblPl, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        return headerView
    }
    */
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingscell") as! SettingsCell
        if indexPath.section == 0 {
            cell.lblNameQuest.text = quest[indexPath.row]
            cell.txtAnswer.text = ans[indexPath.row]
            cell.privacySwitch.isHidden = true
        }
        else {
            cell.lblNameQuest.text = privacy[indexPath.row]
            cell.lblNameQuest.frame.origin.y = 30.0
            cell.txtAnswer.isHidden = true
            cell.privacySwitch.isOn = true
          
        }
        return cell
    }

    @IBAction func btnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDone(_ sender: Any) {
    }
}

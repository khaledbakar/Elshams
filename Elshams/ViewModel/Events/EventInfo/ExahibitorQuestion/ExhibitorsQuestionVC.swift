//
//  ExhibitorsQuestionVC.swift
//  Elshams
//
//  Created by mac on 2/27/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
//import AlamofireImage
import SwiftyJSON

class ExhibitorsQuestionVC: BaseViewController ,  UITableViewDataSource ,UITableViewDelegate {

    
    @IBOutlet weak var errorInContainerTxt: UILabel!
    @IBOutlet weak var noDataErrorContainer: UIView!
    @IBOutlet weak var activeLoader: UIActivityIndicatorView!
    var questionList = Array<StartupExhibitorsData>()
    
    @IBOutlet weak var questionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Exhibitors Questions"

        addSlideMenuButton()
        questionTableView.isHidden = true
        activeLoader.startAnimating()
        noDataErrorContainer.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(errorAlert), name: NSNotification.Name("ErrorConnections"), object: nil)
        loadQuestionData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    
    @objc func errorAlert(){
        let alert = UIAlertController(title: "Error!", message: Service.errorConnection, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        activeLoader.isHidden = true
        questionTableView.isHidden = true
        
        
    }
    
    func loadQuestionData()  {
        if let  apiToken  = Helper.getApiToken() {
            Service.getService(url: URLs.getQuestionsStratupExhibitors) { // authorizre or not ?  WithAuth
                (response) in
                print(response)
                let json = JSON(response)
                let result = json["All"]
                print("All question \(result)")
                if !(result.isEmpty){
                    
                    var iDNotNull = true
                    var index = 0
                    while iDNotNull {
                        let question_ID = result[index]["questionId"].string
                        let question_head = result[index]["question"].string
                        let question_answer = result[index]["answer"].string
                        let question_sideName = result[index]["sideName"].string
                        let question_type = result[index]["type"].string
                        let question_TimeStamp = result[index]["questionTimeStamp"].string
                        
                        if question_ID == nil || question_ID?.trimmed == "" || question_ID == "null" || question_ID == "nil" {
                            iDNotNull = false
                            break
                        }
                        self.questionList.append(StartupExhibitorsData(Questions: question_head ?? "", Answer: question_answer ?? "", QuestionsID: question_ID ?? "", QuestionSideName: question_sideName ?? "", QuestionType: question_type ?? "", QuestionTimeStamp: question_TimeStamp ?? ""))
                        
                        index = index + 1
                        self.questionTableView.reloadData()
                        self.activeLoader.isHidden = true
                        self.activeLoader.stopAnimating()
                        self.questionTableView.isHidden = false
                        self.noDataErrorContainer.isHidden = true
                        
                    }
                } else {
                    self.noDataErrorContainer.isHidden = false
                    let alert = UIAlertController(title: "No Data", message: "No Data found till now", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.activeLoader.isHidden = true
                }
            }
            
        }else {
            self.activeLoader.isHidden = true
            self.questionTableView.isHidden = true
            //  print(error.localizedDescription)
            let alert = UIAlertController(title: "Error", message: "You must sign in to Show this Part", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            dismiss(animated: true, completion: nil)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exhibtorsquestioncell") as! ExhibitorsQuestionCell
        cell.setAllQuestionCell(QuestionList: questionList[indexPath.row])
        return cell
    }


}

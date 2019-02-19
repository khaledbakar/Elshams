//
//  MyQuestions.swift
//  Elshams
//
//  Created by mac on 12/6/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire
//import AlamofireImage
import SwiftyJSON

class MyQuestions: UIViewController , UITableViewDataSource ,UITableViewDelegate {
    var questionList = Array<QuestionsData>()
    @IBOutlet weak var activeLoader: UIActivityIndicatorView!
    @IBOutlet weak var noDataErrorContainer: UIView!

    @IBOutlet weak var questionTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        questionTableView.isHidden = true
        activeLoader.startAnimating()
        noDataErrorContainer.isHidden = true

         NotificationCenter.default.addObserver(self, selector: #selector(errorAlert), name: NSNotification.Name("ErrorConnections"), object: nil)
        loadMyQuestionData()
 
    }
    
    @objc func errorAlert(){
        let alert = UIAlertController(title: "Error!", message: Service.errorConnection, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        questionTableView.isHidden = true
        activeLoader.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    
    func loadMyQuestionData()  {
        if let  apiToken  = Helper.getApiToken() {

        Service.getServiceWithAuth(url: URLs.getQuestions) { // authorizre or not ?
            (response) in
            print(response)
            let json = JSON(response)
            let result = json["myQuestions"]
            print("All question \(result)")

            if !(result.isEmpty){

            var iDNotNull = true
            var index = 0
            while iDNotNull {
                let question_ID = result[index]["questionId"].string
                let question_head = result[index]["question"].string
                let question_answer = result[index]["answer"].string
                let question_TimeStamp = result[index]["questionTimeStamp"].string
                
                if question_ID == nil || question_ID?.trimmed == "" || question_ID == "null" || question_ID == "nil" {
                    iDNotNull = false
                    break
                }
                self.questionList.append(QuestionsData(Questions: question_head ?? "", Answer: question_answer ?? "", QuestionsID: question_ID ?? "", QuestionTimeStamp: question_TimeStamp ?? ""))
                
                index = index + 1
                self.noDataErrorContainer.isHidden = true

                self.questionTableView.reloadData()
                self.activeLoader.isHidden = true
                self.activeLoader.stopAnimating()
                self.questionTableView.isHidden = false
            }
            }else {
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
            // and should dimiss
            
        }
    }
    //table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionList.count
    }
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190.0
    } */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myquestioncell") as! MyQuestionsCell
        cell.setMyQuestionCell(QuestionList: questionList[indexPath.row])
        return cell
    }
    
}
extension MyQuestions : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "MyQuestions")
    }
}


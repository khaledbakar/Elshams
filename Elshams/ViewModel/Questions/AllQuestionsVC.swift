//
//  AllQuestionsVC.swift
//  Elshams
//
//  Created by mac on 12/6/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import AlamofireImage
import SwiftyJSON


class AllQuestionsVC: UIViewController , UITableViewDataSource ,UITableViewDelegate {
    
    @IBOutlet weak var activeLoader: UIActivityIndicatorView!
    var questionList = Array<QuestionsData>()

    @IBOutlet weak var questionTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

      /*  questionList.append(QuestionsData(Questions: "What is the chiefly responsible for the increase in the average length of life in USA during the last fifty years?", Answer: "No Answer", AnswerArr: ["a.the reduced death rate among infants.","b.The subistituation of machine for human","c.Compulsory health and physical education."], IdQuset: 0))
        
        questionList.append(QuestionsData(Questions: "What is the chiefly responsible for the increase in the average length of life in USA during the last thirty years?", Answer: "the reduced death rate among infants or Compulsory health and physical education", AnswerArr: ["a.Compulsory health and physical education.","b.the reduced death rate among infants.","c.The subistituation of machine for human"], IdQuset: 1)) */
        questionTableView.isHidden = true
        activeLoader.startAnimating()
        loadQuestionData()

        
    }
    
    
    func loadQuestionData()  {
        Service.getServiceWithAuth(url: URLs.getQuestions) { // authorizre or not ?
            (response) in
            print(response)
            let json = JSON(response)
            let result = json["All"]
            
            var iDNotNull = true
            var index = 0
            while iDNotNull {
                let question_ID = result[index]["ID"].string
                let question_head = result[index]["question"].string
                let question_answer = result[index]["answer"].string
                let question_TimeStamp = result[index]["questionTimeStamp"].string
              
                if question_ID == nil || question_ID?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || question_ID == "null" || question_ID == "nil" {
                    iDNotNull = false
                    break
                }
                self.questionList.append(QuestionsData(Questions: question_head ?? "question", Answer: question_answer ?? "answer", QuestionsID: question_ID ?? "ID", QuestionTimeStamp: question_TimeStamp ?? "TimeStamp"))
                
                index = index + 1
                self.questionTableView.reloadData()
                self.activeLoader.isHidden = true
                self.activeLoader.stopAnimating()
                self.questionTableView.isHidden = false
            }
            //  print((self.networkList[2].name)!)
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionList.count
    }
    
   /* func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190.0
    }
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allquestioncell") as! AllQuestionsCell
        cell.setAllQuestionCell(QuestionList: questionList[indexPath.row])
        return cell
    }

}
extension AllQuestionsVC : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "AllQuestionsVC")
    }
}


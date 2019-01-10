//
//  MyQuestions.swift
//  Elshams
//
//  Created by mac on 12/6/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MyQuestions: UIViewController , UITableViewDataSource ,UITableViewDelegate {
    var questionList = Array<QuestionsData>()

    override func viewDidLoad() {
        super.viewDidLoad()


        questionList.append(QuestionsData(Questions: "What is the chiefly responsible for the increase in the average length of life in USA during the last fifty years?", Answer: "the reduced death rate among infants", AnswerArr: ["a.the reduced death rate among infants.","b.The subistituation of machine for human","c.Compulsory health and physical education."], IdQuset: 0))
        
        questionList.append(QuestionsData(Questions: "What is the chiefly responsible for the increase in the average length of life in USA during the last thirty years?", Answer: "No Answer", AnswerArr: ["a.Compulsory health and physical education.","b.the reduced death rate among infants.","c.The subistituation of machine for human"], IdQuset: 1))
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


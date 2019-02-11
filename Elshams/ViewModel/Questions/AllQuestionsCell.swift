//
//  AllQuestionsCell.swift
//  Elshams
//
//  Created by mac on 12/6/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class AllQuestionsCell: UITableViewCell {

    @IBOutlet weak var answerTxt: UILabel!
    @IBOutlet weak var questionTxt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func setAllQuestionCell(QuestionList:QuestionsData)  {
        questionTxt.text = QuestionList.questions
        if QuestionList.answer == "" || QuestionList.answer == nil{
            answerTxt.text = "No Answer"
            answerTxt.textColor = UIColor.red
        } else {
            answerTxt.text = QuestionList.answer
             answerTxt.textColor = UIColor(hex: 0xC2C2C0)
            
        }
        
    }
}

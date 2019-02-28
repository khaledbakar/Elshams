//
//  ExhibitorsQuestionCell.swift
//  Elshams
//
//  Created by mac on 2/27/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ExhibitorsQuestionCell: UITableViewCell {
    @IBOutlet weak var answerTxt: UILabel!
    @IBOutlet weak var questionTxt: UILabel!
    @IBOutlet weak var sideName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setAllQuestionCell(QuestionList:StartupExhibitorsData)  {
        questionTxt.text = QuestionList.questions
        if QuestionList.questionSideName == "" || QuestionList.questionSideName == nil{
            sideName.isHidden = true

        }
        else {
            sideName.isHidden = false
            sideName.text = QuestionList.questionSideName

        }
        
        if QuestionList.answer == "" || QuestionList.answer == nil{
            answerTxt.text = "No Answer"
            answerTxt.textColor = UIColor.red
        } else {
            answerTxt.text = QuestionList.answer
            answerTxt.textColor = UIColor(hex: 0xC2C2C0)
        }
        
    }
}

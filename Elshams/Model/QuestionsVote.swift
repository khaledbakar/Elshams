//
//  QuestionsVote.swift
//  Elshams
//
//  Created by mac on 2/12/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
class QuestionsVote {
    var question : String?
    var questionsID : String?
    var questionAnswer : [MultiAnswers]
    init(Questions:String,QuestionAnswer:[MultiAnswers],QuestionsID:String) { //,AnswerArr:[String]
        self.question = Questions
        self.questionAnswer = QuestionAnswer
        self.questionsID = QuestionsID
        
    }

}

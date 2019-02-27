//
//  QuestionsData.swift
//  Elshams
//
//  Created by mac on 12/6/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class QuestionsData {   
        var questions : String?
        var questionsID : String?
        var answer : String?
       // var answerArr :[String]?
        var questionTimeStamp : String?
        var questionSpeaker : String?

    init(Questions:String,Answer:String,QuestionsID:String,QuestionSpeaker:String,QuestionTimeStamp:String) { //,AnswerArr:[String]
            self.questions = Questions
            self.answer = Answer
            self.questionsID = QuestionsID
            self.questionTimeStamp = QuestionTimeStamp
            self.questionSpeaker = QuestionSpeaker
        
        }
}

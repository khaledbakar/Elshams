//
//  StartupExhibitorsData.swift
//  Elshams
//
//  Created by mac on 2/27/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


class StartupExhibitorsData {
    var questions : String?
    var questionsID : String?
    var answer : String?
    var questionTimeStamp : String?
    var questionSideName : String?
    var questionType : String?

    
    init(Questions:String,Answer:String,QuestionsID:String,QuestionSideName:String,QuestionType:String,QuestionTimeStamp:String) { //,AnswerArr:[String]
        self.questions = Questions
        self.answer = Answer
        self.questionsID = QuestionsID
        self.questionTimeStamp = QuestionTimeStamp
        self.questionSideName = QuestionSideName
        self.questionType = QuestionType

        
    }
}

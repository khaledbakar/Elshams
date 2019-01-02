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
        var answer : String?
        var answerArr :[String]?
        var idQuset : Int?
    
    
    init(Questions:String,Answer:String,AnswerArr:[String],IdQuset:Int) {
            self.questions = Questions
            self.answer = Answer
            self.answerArr = AnswerArr
            self.idQuset = IdQuset
        
        }
}

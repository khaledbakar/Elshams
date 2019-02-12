//
//  MultiAnswers.swift
//  Elshams
//
//  Created by mac on 2/12/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
class MultiAnswers {
    var answerID : String?
    var answerTitle : String?
    var voteNo : String?

    init(AnswerID:String,AnswerTitle:String,VoteNo:String) { //,AnswerArr:[String]
        self.answerID = AnswerID
        self.answerTitle = AnswerTitle
        self.voteNo = VoteNo
        
    }

}

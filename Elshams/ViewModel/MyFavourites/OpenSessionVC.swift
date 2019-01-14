//
//  OpenSessionVC.swift
//  Elshams
//
//  Created by mac on 12/5/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class OpenSessionVC: UIViewController {
    static var AgednaOrFavourite:Bool = true
    var singleItem:ProgramAgendaItems?
    var quest = Array<QuestionsData>()
    var answerSelect:String?

    @IBOutlet weak var sessionTitle: UILabel!
    @IBOutlet weak var sessionDate: UILabel!
    @IBOutlet weak var sessionLocation: UILabel!
    @IBOutlet weak var sessionTime: UILabel!
    @IBOutlet weak var speakerName: UILabel!
    @IBOutlet weak var speakerJobTitle: UILabel!
    @IBOutlet weak var speakerProfile: UIImageView!
    
    @IBOutlet weak var backQuestion: UIImageView!
    @IBOutlet weak var nextQuestion: UIImageView!
    @IBOutlet weak var questionsTxt: UITextView!
    @IBOutlet weak var eventDescribtion: UITextView!
    @IBOutlet weak var viewFavBack: UIView!
    @IBOutlet weak var sessionDescribtion: UITextView!
    @IBOutlet weak var questionAnsContainer: UIView!
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var frameBtn = CGRect(x: 0, y: 0, width: 0, height: 0)


    var initQuestion : Int = 0
    
    @IBOutlet weak var sessionQuestion: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // nextQuestion.ges
        if  OpenSessionVC.AgednaOrFavourite == true {
            self.navigationItem.title = "Agenda"

        } else {
            self.navigationItem.title = "My Favourite"

        }
        viewFavBack.layer.cornerRadius = viewFavBack.frame.width / 2
        viewFavBack.clipsToBounds = true
        
        quest.append(QuestionsData(Questions: "What is the chiefly responsible for the increase in the average length of life in USA during the last fifty years?", Answer: "b", AnswerArr: ["a.the reduced death rate among infants.","b.The subistituation of machine for human","c.Compulsory health and physical education."], IdQuset: 0))
        
         quest.append(QuestionsData(Questions: "What is the chiefly responsible for the increase in the average length of life in USA during the last thirty years?", Answer: "a", AnswerArr: ["a.Compulsory health and physical education.","b.the reduced death rate among infants.","c.The subistituation of machine for human"], IdQuset: 1))
         quest.append(QuestionsData(Questions: "What is the chiefly responsible for the increase in the average length of life in USA during the last seventy years?", Answer: "c", AnswerArr: ["a.The subistituation of machine for human","b.Compulsory health and physical education.","c.the reduced death rate among infants."], IdQuset: 2))
        
        print("count of answer arr \(quest[0].answerArr?.count)")
        questionsTxt.text = quest[0].questions
        
        for i in 0..<1{
          //  for i in 0..<quest.count{
            var qu = Int(quest[i].answerArr!.count)
        for index in 0..<qu {
            frame.origin.x = 45
            frame.origin.y = (40 * CGFloat(index))
            frame.size = CGSize(width: 200 , height: 20.0)
            let lblAnswers = UILabel(frame: frame)
            lblAnswers.text = quest[i].answerArr?[index]
            lblAnswers.textColor = UIColor.darkGray
            lblAnswers.font = lblAnswers.font.withSize(13.0)
            frameBtn.origin.x = 0
            frameBtn.origin.y = (40 * CGFloat(index))
            frameBtn.size = CGSize(width: 40 , height: 20.0)
            var btnCheck = UIButton(frame: frameBtn)
            btnCheck.setTitle("\(index)", for: .normal)
            btnCheck.isSelected = false
            btnCheck.addTarget(self, action: #selector(butClic(_:)), for: .touchUpInside)
            btnCheck.setImage(UIImage(named: "unCheck"), for: UIControlState.normal)
            btnCheck.setImage(UIImage(named: "check-1"), for: UIControlState.selected)
            btnCheck.tag = index + 1
            questionAnsContainer.addSubview(lblAnswers)
            questionAnsContainer.addSubview(btnCheck)
        }
        }

    }
    
    @IBAction func backQuestionBtn(_ sender: Any) {
        print(initQuestion)

        if initQuestion <= 0{
            print("Illegal")
        }
        else {
            initQuestion = initQuestion - 1
            questionsTxt.text = quest[initQuestion].questions
            var ansInd = 0
            for ind in 0..<questionAnsContainer.subviews.count {
                if ind % 2 == 0 {
                    (questionAnsContainer.subviews[ind] as! UILabel).text = quest[initQuestion].answerArr![ansInd]
                    ansInd = ansInd + 1
                } else {
                    continue
                }
            }
        }
    }
    
    @IBAction func nextQuestionBtn(_ sender: Any) {
        

        print(initQuestion)
        if initQuestion >= quest.count - 1 {
            print("Illegal")
        }
        else {
            initQuestion = initQuestion + 1
            questionsTxt.text = quest[initQuestion].questions
            var ansInd = 0
            for ind in 0..<questionAnsContainer.subviews.count {
                if ind % 2 == 0 {
                    (questionAnsContainer.subviews[ind] as! UILabel).text = quest[initQuestion].answerArr![ansInd]
                    ansInd = ansInd + 1
                } else {
                    continue
                }
            }
            
        }
            }
    
    @objc func butClic (_ sender: UIButton){
        for ind in 0..<questionAnsContainer.subviews.count {
            if ind % 2 == 1 {
                print(ind)
                print(questionAnsContainer.subviews[ind])
                (questionAnsContainer.subviews[ind] as! UIButton).isSelected = false
            } else {
                continue
            }
        }
        
        sender.isSelected = true
        let  buTitle = "\((sender.currentTitle)!)"
        let buTitleInt = sender.tag - 1
        print(buTitleInt)
        //quest[num]
        answerSelect = quest[initQuestion].answerArr?[buTitleInt]
        print(answerSelect)

    }
    @IBAction func askSpeaker(_ sender: Any) {
    }
    
    @IBAction func vote(_ sender: Any) {
    }
    

}

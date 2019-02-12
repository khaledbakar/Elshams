//
//  OpenSessionVC.swift
//  Elshams
//
//  Created by mac on 12/5/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class OpenSessionVC: UIViewController , UITextViewDelegate{
    static var AgednaOrFavourite:Bool = true
    var singleItem:ProgramAgendaItems?
    var quest = Array<QuestionsData>()
    var questVotes = Array<QuestionsVote>()
    var questionAnswerVote = Array<MultiAnswers>()


    var answerSelect:String?
    @IBOutlet weak var backSpeakerBtn: UIButton!
    @IBOutlet weak var nextSpeakerBtnImg: UIImageView!
    
    @IBOutlet weak var sendQuestMainContainer: UIView!
    @IBOutlet weak var askSpeakerContainer: UIView!
    
    @IBOutlet weak var questionTxt: UITextView!
    static var likeFlag :String?

    @IBOutlet weak var backSpeakerBtnImg: UIImageView!
    @IBOutlet weak var nextSpeakerBtn: UIButton!
    
    var speakerCounterIndex : Int = 0
    
    var session_ID :String?
    var session_RondomColor :String?
    var session_Type :String?
    var session_Date :String?
    var session_Title :String?
    var session_Time :String?
    var session_Location :String?
    var session_Description :String?
    var session_isFavourate :Bool?
    var session_isFavourate_Str :String?
    var session_TwitterHash :String? //mst5dmt-hash
    var speakerImagesCash :[Image]?
    
    var speaker_ID :String?
    var speaker_Name :String?
    var speaker_JobTitle :String?
    var speaker_CompanyName :String?
    var speaker_ImageUrl :String?
    var speaker_About :String?
    var speaker_ContectInforamtion :[String:Any]?
    var speaker_Email :String?
    var speaker_Linkedin :String?
    var speaker_Phone :String?
    
    var question_ID :String?
    var question_head :String?
    var question_answer :String?
    var question_TimeStamp :String?

    @IBOutlet weak var sessionTitle: UILabel!
    @IBOutlet weak var sessionDate: UILabel!
    @IBOutlet weak var sessionLocation: UILabel!
    @IBOutlet weak var sessionTime: UILabel!
    @IBOutlet weak var speakerName: UILabel!
    @IBOutlet weak var speakerJobTitle: UILabel!
    @IBOutlet weak var speakerProfile: UIImageView!
    @IBOutlet weak var favouriteIcon: UIImageView!
    
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
    var speakerList = Array<Speakers>()
    //var startUpList = Array<StartUpsData>()
    var sessionList = Array<ProgramAgendaItems>()
    var questionList = Array<QuestionsData>()
    var agendaSpeakerIDImgList = Array<AgendaSpeakerIdPic>()

    
    override func viewDidLoad() {
        super.viewDidLoad()
       // nextQuestion.ges
        //default empty label
        sessionTitle.text = ""
        sessionDate.text = ""
        sessionTime.text = ""
        sessionLocation.text = ""
        speakerName.text = ""
        speakerJobTitle.text = ""
       // speakerName.isHidden = true
        //speakerProfile.isHidden = true
        
      //  discrepFrame
        OpenSessionVC.likeFlag = "notFavMethod"

        eventDescribtion.text = ""
        questionsTxt.text = ""
        speakerProfile.layer.cornerRadius = speakerProfile.frame.width / 2
        speakerProfile.clipsToBounds = true
        viewFavBack.layer.cornerRadius = viewFavBack.frame.width / 2
        viewFavBack.clipsToBounds = true
        sendQuestMainContainer.isHidden = true
        self.questionTxt.delegate = self
        self.questionTxt.layer.borderWidth = 1.0
        questionTxt.layer.borderColor = UIColor.red.cgColor
        
       // questionTxt.
        favouriteIcon.image = UIImage(named: "unlike-session")
        loadSessionData(SessionID: (singleItem?.agenda_ID)!)
        if  OpenSessionVC.AgednaOrFavourite == true {
            self.navigationItem.title = "Agenda"

        } else {
            self.navigationItem.title = "My Favourite"

        }
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RegisterationVC.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)

       

    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    
    
    func hideKyebad() {
        questionTxt.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.askSpeakerContainer.endEditing(true)
        askSpeakerContainer.frame.origin.y = 0
        
    }
    
    @objc func keyboardWillChange(notification: Notification){
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if  notification.name == Notification.Name.UIKeyboardWillShow ||
            notification.name == Notification.Name.UIKeyboardWillChangeFrame {
           // view.frame.origin.y = -150
            sendQuestMainContainer.frame.origin.y = -150

        } else {
            sendQuestMainContainer.frame.origin.y = 0
        }
        print("Keyboard will show \(notification.name.rawValue)")
        //  view.frame.origin.y = -150
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer)  {
        sendQuestMainContainer.endEditing(true)
    }
    
    func loadSessionData(SessionID:String)  {
       // if user logIN Authorize use this
        /*   Service.getServiceWithAuth(url: "http://66.226.74.85:4002/api/Event/getSessionDetails/\((self.singleItem?.agenda_ID)!)") {
         (response) in
         print("this is favour ")
         print(response)
         }
         */
        if let  apiToken  = Helper.getApiToken() {

     Service.getServiceWithAuth(url: "\(URLs.getSessionDetails)/\(SessionID)") {
            (response) in
        print("this is SessionDetails ")
           print(response)
            let result = JSON(response)
                 self.session_ID = result["Id"].string
                 self.session_RondomColor = result["rondomColor"].string
                 self.session_Type = result["type"].string
                 self.session_Date = result["date"].string
                 self.session_Title = result["sessionTitle"].string
                 self.session_Time = result["time"].string
                 self.session_Location = result["location"].string
                 self.session_Description = result["description"].string
                 self.session_isFavourate = result["isFavourate"].bool
                 self.session_isFavourate_Str = "\(self.session_isFavourate)"
        
                 self.session_TwitterHash = result["twitterHash"].string //mst5dmt-hash
        let speaker_ID_Image = result["Speaker"].dictionaryObject
        // get speakers // from agendaIdImg get all not only [0]
        let speaker_all = result["Speaker"]["AllSpeaker"]
        var iDSpeakerNotNull = true
        var indexSpeaker = 0
        while iDSpeakerNotNull {
            let speaker_ID = speaker_all[indexSpeaker]["ID"].string
            if speaker_ID == nil || speaker_ID?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || speaker_ID == "null" || speaker_ID == "nil" {
                iDSpeakerNotNull = false
                break
            }
            let speaker_Name = speaker_all[indexSpeaker]["name"].string
            let speaker_JobTitle = speaker_all[indexSpeaker]["jobTitle"].string
            let speaker_CompanyName = speaker_all[indexSpeaker]["companyName"].string
            let speaker_ImageUrl = speaker_all[indexSpeaker]["imageUrl"].string
            let speaker_About = speaker_all[indexSpeaker]["about"].string
            let speaker_ContectInforamtion = speaker_all[indexSpeaker]["ContectInforamtion"].dictionaryObject
            let speaker_Email = speaker_all[indexSpeaker]["ContectInforamtion"]["Email"].string
            let speaker_Linkedin = speaker_all[indexSpeaker]["ContectInforamtion"]["linkedin"].string
            let speaker_Phone = speaker_all[indexSpeaker]["ContectInforamtion"]["phone"].string
            
            let contect = ["Email": "",
                           "linkedin": "",
                           "phone": ""]
            
            self.speakerList.append(Speakers(SpeakerName: speaker_Name ?? "name", JobTitle: speaker_JobTitle ?? "JOB", CompanyName: speaker_CompanyName ?? "Company", SpImageUrl: speaker_ImageUrl ?? "Image", Speaker_id: speaker_ID ?? "ID", ContectInforamtion: speaker_ContectInforamtion ?? contect, About: speaker_About ?? "About"))
            indexSpeaker = indexSpeaker + 1
        }
        let questions_all = result["Question"]["AllQuestion"]
        print("this is question")
        print(questions_all)
        var iDQuesionNotNull = true
        var indexQuestion = 0
        while iDQuesionNotNull {
            let questionFirstloop_ID = questions_all[indexQuestion]["ID"].string
       //     self.question_ID = questions_all[indexQuestion]["ID"].string
            if questionFirstloop_ID == nil || questionFirstloop_ID?.trimmed == "" || questionFirstloop_ID == "null" || questionFirstloop_ID == "nil" {
                iDQuesionNotNull = false
                break
            }
        let questionFirstloop_q = questions_all[indexQuestion]["question"].string
            let questionFirstloop_qestionAnswers = questions_all[indexQuestion]["Question_Answer"]

            var iDQuesionAnswersNotNull = true
            var indexQuestionAns = 0
            while iDQuesionAnswersNotNull {
                let answer_ID = questionFirstloop_qestionAnswers[indexQuestionAns]["answerID"].string
                if answer_ID == nil || answer_ID?.trimmed == "" || answer_ID == "null" || answer_ID == "nil" {
                    iDQuesionAnswersNotNull = false
                    break
                }
                let answer_Title = questionFirstloop_qestionAnswers[indexQuestionAns]["answerTitle"].string
                let vote_No = questionFirstloop_qestionAnswers[indexQuestionAns]["VoteNo"].string
                
                self.questionAnswerVote.append((MultiAnswers(AnswerID: answer_ID ?? "", AnswerTitle: answer_Title ?? "", VoteNo: vote_No ?? "")))

            indexQuestionAns = indexQuestionAns + 1
            }
            self.questVotes.append((QuestionsVote(Questions: questionFirstloop_q ?? "", QuestionAnswer: self.questionAnswerVote, QuestionsID: questionFirstloop_ID ?? "")))
      //  self.question_head = questions_all["question"].string
     //   self.question_answer = questions_all["answer"].string
      //  self.question_TimeStamp = questions_all["questionTimeStamp"].string
            
       // self.speakerList.removeAll()
     //   self.questionList.removeAll()
     //   self.sessionList.removeAll()
            indexQuestion = indexQuestion + 1
        }
    
       /* self.speakerList.append(Speakers(SpeakerName: self.speaker_Name ?? "name", JobTitle: self.speaker_JobTitle ?? "JOB", CompanyName: self.speaker_CompanyName ?? "Company", SpImageUrl: self.speaker_ImageUrl ?? "Image", Speaker_id: self.speaker_ID ?? "ID", ContectInforamtion: self.speaker_ContectInforamtion ?? contect, About: self.speaker_About ?? "About")) */
     //   self.questionList.append(QuestionsData(Questions: self.question_head ?? "question", Answer: self.question_answer ?? "answer", QuestionsID: self.question_ID ?? "ID", QuestionTimeStamp: self.question_TimeStamp ?? "TimeStamp"))
        
        self.sessionList.append(ProgramAgendaItems(Agenda_ID: self.session_ID ?? "ID", SessionTitle: self.session_Title ?? "Title", SessionTime: self.session_Time ?? "Time", SessionLocation: self.session_Location ?? "location", SpeakersSession: ["ID" : "314",
            "imageUrl" : "http:-b01d-582382a5795e.jpg"]
            , AgendaDate: self.session_Date ?? "date", FavouriteSession: self.session_isFavourate ?? true , FavouriteSessionStr: self.session_isFavourate_Str ?? "true" , RondomColor: self.session_RondomColor ?? "red", AgendaType: self.session_Type ?? "session", SpeakersIdImg: self.agendaSpeakerIDImgList))
        
        
        if self.session_isFavourate == true {
            self.favouriteIcon.image = UIImage(named: "like-session")
        }else {
            self.favouriteIcon.image = UIImage(named: "unlike-session")
        }
        //fix question
        self.questionTxt.text = self.questVotes[0].question
        
        self.mangeSessionDetails(SeseionTitle: self.session_Title ?? "Title", AgendaDate: self.session_Date ?? "date", SessionTime:  self.session_Time ?? "Time", SessionLocation: self.session_Location ?? "location", SessionDescribtion: self.session_Description ?? "Describition", SpeakerName: self.speaker_Name ?? "name", SpeakerJobTitle: self.speaker_JobTitle ?? "JOB", SpeakerImgUrl: self.speaker_ImageUrl ?? "Image", QestionHead: self.question_head ?? "question", Speakers: self.speakerList)
        
        }
        }else {
            
            Service.getService(url: "\(URLs.getSessionDetails)/\(SessionID)") {
                (response) in
                print("this is SessionDetails ")
                print(response)
                let result = JSON(response)
                self.session_ID = result["Id"].string
                self.session_RondomColor = result["rondomColor"].string
                self.session_Type = result["type"].string
                self.session_Date = result["date"].string
                self.session_Title = result["sessionTitle"].string
                self.session_Time = result["time"].string
                self.session_Location = result["location"].string
                self.session_Description = result["description"].string
                self.session_isFavourate = result["isFavourate"].bool
                self.session_isFavourate_Str = "\(self.session_isFavourate)"
                
                self.session_TwitterHash = result["twitterHash"].string //mst5dmt-hash
                let speaker_ID_Image = result["Speaker"].dictionaryObject
                // get speakers // from agendaIdImg get all not only [0]
                let speaker_all = result["Speaker"]["AllSpeaker"]
                var iDSpeakerNotNull = true
                var indexSpeaker = 0
                while iDSpeakerNotNull {
                    let speaker_ID = speaker_all[indexSpeaker]["ID"].string
                    if speaker_ID == nil || speaker_ID?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || speaker_ID == "null" || speaker_ID == "nil" {
                        iDSpeakerNotNull = false
                        break
                    }
                    let speaker_Name = speaker_all[indexSpeaker]["name"].string
                    let speaker_JobTitle = speaker_all[indexSpeaker]["jobTitle"].string
                    let speaker_CompanyName = speaker_all[indexSpeaker]["companyName"].string
                    let speaker_ImageUrl = speaker_all[indexSpeaker]["imageUrl"].string
                    let speaker_About = speaker_all[indexSpeaker]["about"].string
                    let speaker_ContectInforamtion = speaker_all[indexSpeaker]["ContectInforamtion"].dictionaryObject
                    let speaker_Email = speaker_all[indexSpeaker]["ContectInforamtion"]["Email"].string
                    let speaker_Linkedin = speaker_all[indexSpeaker]["ContectInforamtion"]["linkedin"].string
                    let speaker_Phone = speaker_all[indexSpeaker]["ContectInforamtion"]["phone"].string
                    
                    let contect = ["Email": "",
                                   "linkedin": "",
                                   "phone": ""]
                    
                    self.speakerList.append(Speakers(SpeakerName: speaker_Name ?? "name", JobTitle: speaker_JobTitle ?? "JOB", CompanyName: speaker_CompanyName ?? "Company", SpImageUrl: speaker_ImageUrl ?? "Image", Speaker_id: speaker_ID ?? "ID", ContectInforamtion: speaker_ContectInforamtion ?? contect, About: speaker_About ?? "About"))
                    indexSpeaker = indexSpeaker + 1
                }
                let questions_all = result["Question"]["AllQuestion"]
                print("this is question")
                print(questions_all)
                var iDQuesionNotNull = true
                var indexQuestion = 0
                while iDQuesionNotNull {
                    let questionFirstloop_ID = questions_all[indexQuestion]["ID"].string
                    //     self.question_ID = questions_all[indexQuestion]["ID"].string
                    if questionFirstloop_ID == nil || questionFirstloop_ID?.trimmed == "" || questionFirstloop_ID == "null" || questionFirstloop_ID == "nil" {
                        iDQuesionNotNull = false
                        break
                    }
                    let questionFirstloop_q = questions_all[indexQuestion]["question"].string
                    let questionFirstloop_qestionAnswers = questions_all[indexQuestion]["Question_Answer"]
                    
                    var iDQuesionAnswersNotNull = true
                    var indexQuestionAns = 0
                    while iDQuesionAnswersNotNull {
                        let answer_ID = questionFirstloop_qestionAnswers[indexQuestionAns]["answerID"].string
                        if answer_ID == nil || answer_ID?.trimmed == "" || answer_ID == "null" || answer_ID == "nil" {
                            iDQuesionAnswersNotNull = false
                            break
                        }
                        let answer_Title = questionFirstloop_qestionAnswers[indexQuestionAns]["answerTitle"].string
                        let vote_No = questionFirstloop_qestionAnswers[indexQuestionAns]["VoteNo"].string
                        
                        self.questionAnswerVote.append((MultiAnswers(AnswerID: answer_ID ?? "", AnswerTitle: answer_Title ?? "", VoteNo: vote_No ?? "")))
                        
                        indexQuestionAns = indexQuestionAns + 1
                    }
                    self.questVotes.append((QuestionsVote(Questions: questionFirstloop_q ?? "", QuestionAnswer: self.questionAnswerVote, QuestionsID: questionFirstloop_ID ?? "")))
                    //  self.question_head = questions_all["question"].string
                    //   self.question_answer = questions_all["answer"].string
                    //  self.question_TimeStamp = questions_all["questionTimeStamp"].string
                    
                    // self.speakerList.removeAll()
                    //   self.questionList.removeAll()
                    //   self.sessionList.removeAll()
                    indexQuestion = indexQuestion + 1
                }
                
                self.sessionList.append(ProgramAgendaItems(Agenda_ID: self.session_ID ?? "ID", SessionTitle: self.session_Title ?? "Title", SessionTime: self.session_Time ?? "Time", SessionLocation: self.session_Location ?? "location", SpeakersSession: ["ID" : "314",
                                                                                                                                                                                                                                                              "imageUrl" : "http:-b01d-582382a5795e.jpg"]
                    , AgendaDate: self.session_Date ?? "date", FavouriteSession: self.session_isFavourate ?? true , FavouriteSessionStr: self.session_isFavourate_Str ?? "true" , RondomColor: self.session_RondomColor ?? "red", AgendaType: self.session_Type ?? "session", SpeakersIdImg: self.agendaSpeakerIDImgList))
                
                
                if self.session_isFavourate == true {
                    self.favouriteIcon.image = UIImage(named: "like-session")
                }else {
                    self.favouriteIcon.image = UIImage(named: "unlike-session")
                }
                //fix question
                self.questionTxt.text = self.questVotes[0].question
                
                self.mangeSessionDetails(SeseionTitle: self.session_Title ?? "Title", AgendaDate: self.session_Date ?? "date", SessionTime:  self.session_Time ?? "Time", SessionLocation: self.session_Location ?? "location", SessionDescribtion: self.session_Description ?? "Describition", SpeakerName: self.speaker_Name ?? "name", SpeakerJobTitle: self.speaker_JobTitle ?? "JOB", SpeakerImgUrl: self.speaker_ImageUrl ?? "Image", QestionHead: self.question_head ?? "question", Speakers: self.speakerList)
                
            }
        }
        
    }
    
    func imgUrl(imgUrl:String)  { //,listImage:[UIImage]
        if imgUrl != nil {
            if let imagUrlAl = imgUrl as? String {
                Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                    print(response)
                    
                    switch response.result {
                    case .success(let value):
                        if let image = response.result.value {
                            DispatchQueue.main.async{
                                /*  for data in listImage {
                                 
                                 }*/
                                self.speakerProfile.image = image
                                //    self.speakerImagesCash?[0] = image
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                })
            }
        }
       
    }
    
    func mangeSessionDetails(SeseionTitle:String,AgendaDate:String,SessionTime:String,SessionLocation:String,SessionDescribtion:String,SpeakerName:String,SpeakerJobTitle:String,SpeakerImgUrl:String,QestionHead:String,Speakers:[Speakers]){
 
        if !(SeseionTitle.isEmpty) {
            sessionTitle.text = SeseionTitle
        }
        if !(AgendaDate.isEmpty){
            sessionDate.text = AgendaDate
        }
        if !(SessionTime.isEmpty){
            sessionTime.text = SessionTime
        }
        if !(SessionLocation.isEmpty){
            sessionLocation.text = SessionLocation
        }
        if !(SessionDescribtion.isEmpty){
            let sessionDecribtionHtml = SessionDescribtion.htmlToString
            eventDescribtion.text = sessionDecribtionHtml
        }
        
        if !(Speakers.isEmpty) {
            speakerName.text = Speakers[0].name
            speakerJobTitle.text = Speakers[0].jobTitle
            //array of image and cashe the images
            imgUrl(imgUrl: Speakers[0].speakerImageUrl!)
            
        }
     
       
        if !(QestionHead.isEmpty){
            questionsTxt.text = QestionHead

        }
        
       for i in 0..<questVotes.count{
        //fix at first and then change with tap
         questionsTxt.text =  questVotes[i].question
              for i in 0..<questVotes.count{
                var qu = Int(questVotes[i].questionAnswer.count)
            for index in 0..<qu {
                frame.origin.x = 45
                frame.origin.y = (40 * CGFloat(index))
                frame.size = CGSize(width: 200 , height: 20.0)
                let lblAnswers = UILabel(frame: frame)
                lblAnswers.text = questVotes[i].questionAnswer[index].answerTitle
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
 
    }
    
    @IBAction func backQuestionBtn(_ sender: Any) {
     /*   print(initQuestion)

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
        */
    }
    
    @IBAction func nextQuestionBtn(_ sender: Any) {
        
/*
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
        */
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
        
        print(answerSelect)

    }
    
    @IBAction func backSpeakerMethod(_ sender: Any) {
        if speakerCounterIndex > 0   {
            print(speakerCounterIndex)
            speakerCounterIndex = speakerCounterIndex - 1
            
        }
        if !(speakerList.isEmpty) { // != nil
        speakerName.text = speakerList[speakerCounterIndex].name
        speakerJobTitle.text = speakerList[speakerCounterIndex].jobTitle
        imgUrl(imgUrl: speakerList[speakerCounterIndex].speakerImageUrl!)
        }
      
//cashe image needed
        
    }
    
    @IBAction func sendQuestionBtn(_ sender: Any) {
        let questionTextSend = questionTxt.text
        let questionCheckParam : Parameters =
            ["sessionID": "\((self.singleItem?.agenda_ID)!)",
             "speakerID": "\((speakerList[speakerCounterIndex].speaker_id)!)",
             "question": "\((questionTextSend)!)"]
        Service.postServiceWithAuth(url: URLs.askQuestion, parameters: questionCheckParam) {
            (response) in
            print(response)
            self.questionTxt.text = ""
        }
        
    }
    
    @IBAction func nextSpeakerMethod(_ sender: Any) {
        if speakerCounterIndex < speakerList.count - 1 {
                        print(speakerCounterIndex)
            speakerCounterIndex = speakerCounterIndex + 1

        }
        if !(speakerList.isEmpty) { // != nil
            speakerName.text = speakerList[speakerCounterIndex].name
            speakerJobTitle.text = speakerList[speakerCounterIndex].jobTitle
            imgUrl(imgUrl: speakerList[speakerCounterIndex].speakerImageUrl!)
        }
        
        
    }
    @IBAction func dismissContainer(_ sender: Any) {
        sendQuestMainContainer.isHidden = true
        hideKyebad()

    }
    
    @IBAction func askSpeaker(_ sender: Any) {
        if let  apiToken  = Helper.getApiToken() {
        sendQuestMainContainer.isHidden = false
        } else {
            let alert = UIAlertController(title: "Not Available", message: "You must at first sign in!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func vote(_ sender: Any) {
    }
    
    @IBAction func btnFavouriteSession(_ sender: Any) {
        if let  apiToken  = Helper.getApiToken() {
        let sessionFavID : Parameters = ["sessionID" : "\((self.singleItem?.agenda_ID)!)"]
     
            if self.session_isFavourate == true {
                OpenSessionVC.likeFlag = "faveMethod"
                self.session_isFavourate = false
                self.session_isFavourate_Str = "false"
                self.favouriteIcon.image = UIImage(named: "unlike-session")
                Service.postServiceWithAuth(url: URLs.unfavourateAction, parameters: sessionFavID) {
                    (response) in
                    print(response)
                    let result = JSON(response)
         /*  self.session_isFavourate = false
            self.session_isFavourate_Str = "false"
                    self.favouriteIcon.image = UIImage(named: "unlike-session") */
        }
            }
                else {
                OpenSessionVC.likeFlag = "faveMethod"
                favouriteIcon.image = UIImage(named: "like-session")
                self.session_isFavourate = true
                self.session_isFavourate_Str = "true"
                
            Service.postServiceWithAuth(url: URLs.favourateAction, parameters: sessionFavID) {
                (response) in
                
                print(response)
                let result = JSON(response)
            
            }
           
        }
        } else {
            let alert = UIAlertController(title: "Error", message: "You must sign in to Show this Part", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
          //  dismiss(animated: true, completion: nil)
        }
    }
}

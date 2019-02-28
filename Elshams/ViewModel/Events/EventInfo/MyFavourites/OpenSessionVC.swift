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
    //MARK:- StaticValues
    static var AgednaOrFavourite:String = ""
    static var likeFlag :String?
   
    //MARK:- DataLists
    var singleItem:ProgramAgendaItems?
   // var quest = Array<QuestionsData>()
    var questVotes = Array<QuestionsVote>()
    var questionAnswerVote = Array<MultiAnswers>()
    var speakerList = Array<Speakers>()
    //var startUpList = Array<StartUpsData>()
    var sessionList = Array<ProgramAgendaItems>()
    var questionList = Array<QuestionsData>()
    var agendaSpeakerIDImgList = Array<AgendaSpeakerIdPic>()
    
    
    //MARK:- Containers&Constraints
    @IBOutlet weak var speakerViewContainer: UIView!
    @IBOutlet weak var describtionContainerView: UIView!
    @IBOutlet weak var describtionTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var describeHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var questionContTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextBackQuestionCont: UIView!
    @IBOutlet weak var nextBackSpeakerCont: UIView!
    @IBOutlet weak var questionVoteContainer: UIView!
    
    @IBOutlet weak var backSpeakerBtn: UIButton!
    @IBOutlet weak var nextSpeakerBtnImg: UIImageView!
    
    @IBOutlet weak var sendQuestMainContainer: UIView!
    @IBOutlet weak var askSpeakerContainer: UIView!
    
    @IBOutlet weak var questionTxt: UITextView!

    @IBOutlet weak var backSpeakerBtnImg: UIImageView!
    @IBOutlet weak var nextSpeakerBtn: UIButton!
    
    @IBOutlet weak var nextQuestionBtn: UIButton!
    @IBOutlet weak var backQuestionBtn: UIButton!
    
   
    //MARK:- VariablesInit
    var answerSelect:String?
    var answerSelectTitle:String?

    var speakerCounterIndex : Int = 0
    var initQuestion : Int = 0
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var frameBtn = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    //MARK:- SessionVariablesInit
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
   
    //MARK:- SpeakerVariablesInit
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
    
    //MARK:- QuestionVariablesInit
    var question_ID :String?
    var question_head :String?
    var question_answer :String?
    var question_TimeStamp :String?
    
    //MARK:- IBOutlets
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
    @IBOutlet weak var sessionQuestion: UITextView!
    @IBOutlet weak var activeLoader: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        initalViewLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RegisterationVC.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)

    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    
    func initalViewLoad()  {
        // nextQuestion.ges
        //default empty label
        speakerViewContainer.isHidden = true
        describtionContainerView.isHidden = true
        questionVoteContainer.isHidden = true
        sessionTime.text = "NA"
        sessionDate.text = "NA"
        sessionTitle.text = "NA"
        sessionLocation.text = "NA"
        activeLoader.isHidden = false
        activeLoader.startAnimating()
        
        
        
        let speakerDetailImg = UITapGestureRecognizer(target: self, action: #selector(OpenSessionVC.speakerDetailImg))
        speakerProfile.isUserInteractionEnabled = true
        speakerProfile.addGestureRecognizer(speakerDetailImg)
        
        let speakerDetailName = UITapGestureRecognizer(target: self, action: #selector(OpenSessionVC.speakerDetailLabel))
        speakerName.isUserInteractionEnabled = true
        speakerName.addGestureRecognizer(speakerDetailName)
        
        OpenSessionVC.likeFlag = "notFavMethod"
        
        speakerProfile.layer.cornerRadius = speakerProfile.frame.width / 2
        speakerProfile.clipsToBounds = true
        viewFavBack.layer.cornerRadius = viewFavBack.frame.width / 2
        viewFavBack.clipsToBounds = true
        sendQuestMainContainer.isHidden = true
        self.questionTxt.delegate = self
        self.questionTxt.layer.borderWidth = 1.0
        questionTxt.layer.borderColor = UIColor.red.cgColor
        favouriteIcon.image = UIImage(named: "unlike-session")
        loadSessionData(SessionID: (singleItem?.agenda_ID)!)
        
        self.navigationItem.title = OpenSessionVC.AgednaOrFavourite

       /* if  OpenSessionVC.AgednaOrFavourite == "Agenda" {
            self.navigationItem.title = OpenSessionVC.AgednaOrFavourite
            
        } else {
            self.navigationItem.title = "My Favourite"
        } */
    }
    
    //MARK:- DismmKeyBoard
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
    
    //MARK:- LoadData

    func loadSessionData(SessionID:String)  {
        var urlSession = ""
        if  OpenSessionVC.AgednaOrFavourite == "Agenda" {
           urlSession = URLs.getSessionDetails
        } else if OpenSessionVC.AgednaOrFavourite == "MyFavourites" {
            urlSession = URLs.getFavoriteSessionDetail
        }
        else if OpenSessionVC.AgednaOrFavourite == "Innovation Day" {
            urlSession = URLs.getInnovationSessionDetailsByID
        }
        else if OpenSessionVC.AgednaOrFavourite == "Digital Markting" {
            urlSession = URLs.getDigitalMarketingSessionDetails
        }
        else if OpenSessionVC.AgednaOrFavourite == "Cyber Security" {
            urlSession = URLs.getCyberSecuritySessionDetails
        }
        else {
            urlSession = URLs.getSessionDetails
        }
        if let  apiToken  = Helper.getApiToken() {

     Service.getServiceWithAuth(url: "\(urlSession)/\(SessionID)") {
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
            let speaker_LinkedInOut = result[indexSpeaker]["linkedin"].string // linked in after edit

            let speaker_ContectInforamtion = speaker_all[indexSpeaker]["ContectInforamtion"].dictionaryObject
            let speaker_Email = speaker_all[indexSpeaker]["ContectInforamtion"]["Email"].string
            let speaker_Linkedin = speaker_all[indexSpeaker]["ContectInforamtion"]["linkedin"].string
            let speaker_Phone = speaker_all[indexSpeaker]["ContectInforamtion"]["phone"].string
            
            let contect = ["Email": "","linkedin": "","phone": ""]
            self.speakerList.append(Speakers(SpeakerName: speaker_Name ?? "", JobTitle: speaker_JobTitle ?? "", CompanyName: speaker_CompanyName ?? "", SpImageUrl: speaker_ImageUrl ?? "", Speaker_id: speaker_ID ?? "", ContectInforamtion: speaker_ContectInforamtion ?? contect, About: speaker_About ?? "", LinkedIn: speaker_LinkedInOut ?? ""))
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
            indexQuestion = indexQuestion + 1
        }

        self.sessionList.append(ProgramAgendaItems(Agenda_ID: self.session_ID ?? "", SessionTitle: self.session_Title ?? "", SessionTime: self.session_Time ?? "", SessionLocation: self.session_Location ?? "", SpeakersSession: ["ID" : "314",
            "imageUrl" : "http:-b01d-582382a5795e.jpg"]
            , AgendaDate: self.session_Date ?? "", FavouriteSession: self.session_isFavourate ?? true , FavouriteSessionStr: self.session_isFavourate_Str ?? "" , RondomColor: self.session_RondomColor ?? "", AgendaType: self.session_Type ?? "", SpeakersIdImg: self.agendaSpeakerIDImgList))
        
        if self.session_isFavourate == true {
            self.favouriteIcon.image = UIImage(named: "like-session")
        }else {
            self.favouriteIcon.image = UIImage(named: "unlike-session")
        }
        //fix question
        if !(self.questVotes.isEmpty) {
        self.questionTxt.text = ""
        }
        self.mangeSessionDetails(SeseionTitle: self.session_Title ?? "", AgendaDate: self.session_Date ?? "", SessionTime:  self.session_Time ?? "", SessionLocation: self.session_Location ?? "", SessionDescribtion: self.session_Description ?? "", SpeakerName: self.speaker_Name ?? "", SpeakerJobTitle: self.speaker_JobTitle ?? "", SpeakerImgUrl: self.speaker_ImageUrl ?? "", QestionHead: self.question_head ?? "", Speakers: self.speakerList, QuestVotesParam: self.questVotes)
        
        }
        }else {
            
            Service.getService(url: "\(urlSession)/\(SessionID)") {
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
                let speaker_all = result["Speaker"]["AllSpeaker"]
                var iDSpeakerNotNull = true
                var indexSpeaker = 0
                while iDSpeakerNotNull {
                    let speaker_ID = speaker_all[indexSpeaker]["ID"].string
                    if speaker_ID == nil || speaker_ID?.trimmed == "" || speaker_ID == "null" || speaker_ID == "nil" {
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
                    let speaker_LinkedInOut = result[indexSpeaker]["linkedin"].string // linked in after edit

                    let contect = ["Email": "","linkedin": "","phone": ""]
                    
                    self.speakerList.append(Speakers(SpeakerName: speaker_Name ?? "", JobTitle: speaker_JobTitle ?? "", CompanyName: speaker_CompanyName ?? "", SpImageUrl: speaker_ImageUrl ?? "", Speaker_id: speaker_ID ?? "", ContectInforamtion: speaker_ContectInforamtion ?? contect, About: speaker_About ?? "", LinkedIn: speaker_LinkedInOut ?? ""))
                    indexSpeaker = indexSpeaker + 1
                }
                let questions_all = result["Question"]["AllQuestion"]
                print("this is question")
                print(questions_all)
                var iDQuesionNotNull = true
                var indexQuestion = 0
                while iDQuesionNotNull {
                    let questionFirstloop_ID = questions_all[indexQuestion]["ID"].string
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
                    indexQuestion = indexQuestion + 1
                }
                
                self.sessionList.append(ProgramAgendaItems(Agenda_ID: self.session_ID ?? "", SessionTitle: self.session_Title ?? "", SessionTime: self.session_Time ?? "", SessionLocation: self.session_Location ?? "location", SpeakersSession: ["ID" : "","imageUrl" : ""]
                    , AgendaDate: self.session_Date ?? "", FavouriteSession: self.session_isFavourate ?? true , FavouriteSessionStr: self.session_isFavourate_Str ?? "" , RondomColor: self.session_RondomColor ?? "", AgendaType: self.session_Type ?? "", SpeakersIdImg: self.agendaSpeakerIDImgList))
                
                
                if self.session_isFavourate == true {
                    self.favouriteIcon.image = UIImage(named: "like-session")
                }else {
                    self.favouriteIcon.image = UIImage(named: "unlike-session")
                }
                //fix question
              //  self.questionTxt.text = self.questVotes[0].question
                
                self.mangeSessionDetails(SeseionTitle: self.session_Title ?? "", AgendaDate: self.session_Date ?? "", SessionTime:  self.session_Time ?? "", SessionLocation: self.session_Location ?? "", SessionDescribtion: self.session_Description ?? "", SpeakerName: self.speaker_Name ?? "", SpeakerJobTitle: self.speaker_JobTitle ?? "", SpeakerImgUrl: self.speaker_ImageUrl ?? "", QestionHead: self.question_head ?? "", Speakers: self.speakerList, QuestVotesParam: self.questVotes)
                
            }
        }
        
    }
    
  /*  func imgUrl(imgUrl:String)  { //,listImage:[UIImage]
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
    */
    func mangeSessionDetails(SeseionTitle:String,AgendaDate:String,SessionTime:String,SessionLocation:String,SessionDescribtion:String,SpeakerName:String,SpeakerJobTitle:String,SpeakerImgUrl:String,QestionHead:String,Speakers:[Speakers],QuestVotesParam: [QuestionsVote]){
 
        if !(SeseionTitle.isEmpty) {
            sessionTitle.text = SeseionTitle
        }
        if !(AgendaDate.isEmpty){
            sessionDate.text = AgendaDate
        }
        if !(SessionTime.isEmpty){
            sessionTime.text = SessionTime
        } else {
            sessionTime.text = "NA"

        }
        if !(SessionLocation.isEmpty){
            sessionLocation.text = SessionLocation
        } else {
            sessionLocation.text = "NA"
        }
        
        if !(SessionDescribtion.isEmpty){
            let sessionDecribtionHtml = SessionDescribtion.htmlToString
            eventDescribtion.text = sessionDecribtionHtml
            describtionContainerView.isHidden = false

            
        } else {
            noDescribtionMethod()
        }
        
        //MARK:- Speaker
        if !(Speakers.isEmpty) {
            speakerViewContainer.isHidden = false
            speakerName.text = Speakers[0].name
            speakerJobTitle.text = Speakers[0].jobTitle
            //array of image and cashe the images
            //imgUrl(imgUrl: Speakers[0].speakerImageUrl!)
            Helper.loadImagesKingFisher(imgUrl: Speakers[0].speakerImageUrl!, ImgView: speakerProfile)
            if Speakers.count == 1 {
                nextBackSpeakerCont.isHidden = true
            } else if Speakers.count == 2 {
                nextBackSpeakerCont.isHidden = false
                backQuestionBtn.isHidden = true
                backSpeakerBtnImg.isHidden = true
            }
            
            else {
                nextBackSpeakerCont.isHidden = false
            }
            
        } else {
            noSpeakerMethod()
        }

        //MARK:- QUESTION
        if !(QuestVotesParam.isEmpty) {
            questionVoteContainer.isHidden = false
           if QuestVotesParam.count == 1 {
                nextBackQuestionCont.isHidden = true
           }else if QuestVotesParam.count == 2{
            nextBackQuestionCont.isHidden = false
            backQuestionBtn.isHidden = true
            backQuestion.isHidden = true

           }
           else {
                nextBackQuestionCont.isHidden = false
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
                        lblAnswers.tag = index+1

                        let titleLabelGest = UITapGestureRecognizer(target: self, action: #selector(OpenSessionVC.labelChoiseFunc))
                        lblAnswers.isUserInteractionEnabled = true
                        lblAnswers.addGestureRecognizer(titleLabelGest)
                        frameBtn.origin.x = 0
                        frameBtn.origin.y = (40 * CGFloat(index))
                        frameBtn.size = CGSize(width: 40 , height: 20.0)
                        
                        var btnCheck = UIButton(frame: frameBtn)
                        btnCheck.setTitle("\(index)", for: .normal)
                        btnCheck.isSelected = false
                        btnCheck.addTarget(self, action: #selector(butClic(_:)), for: .touchUpInside)
                        btnCheck.setImage(UIImage(named: "unCheck"), for: UIControlState.normal)
                        btnCheck.setImage(UIImage(named: "check-1"), for: UIControlState.selected)
                        btnCheck.tag = (index + 1) * 2
                        questionAnsContainer.addSubview(lblAnswers)
                        questionAnsContainer.addSubview(btnCheck)
                    }
                }
            }
        } else {
            noQuestionMethod()
        }
        activeLoader.stopAnimating()
        activeLoader.isHidden = true
        
    }
    
    //MARK:- QUESTIONNextBackButtons
    @IBAction func backQuestionBtn(_ sender: Any) {
       print(initQuestion)

        if initQuestion <= 0{
            print("Illegal")
            backQuestionBtn.isHidden = true
            backQuestion.isHidden = true
        }
        else {
            backQuestionBtn.isHidden = false
            backQuestion.isHidden = false
            initQuestion = initQuestion - 1
            if initQuestion == 0 {
                backQuestionBtn.isHidden = true
                backQuestion.isHidden = true
            }
            questionsTxt.text = questVotes[initQuestion].question
            var ansInd = 0
            for ind in 0..<questionAnsContainer.subviews.count {
                if ind % 2 == 0 {
    (questionAnsContainer.subviews[ind] as! UILabel).text = questVotes[initQuestion].questionAnswer[ansInd].answerTitle
                    ansInd = ansInd + 1
                } else {
                    continue
                }
            }
        }
        
    }
    
    @IBAction func nextQuestionBtn(_ sender: Any) {

        print(initQuestion)
        if initQuestion >= questVotes.count - 1 {
            print("Illegal")
            nextQuestion.isHidden = true
            nextQuestionBtn.isHidden = true
        }
        else {
            nextQuestion.isHidden = false
            nextQuestionBtn.isHidden = false
            initQuestion = initQuestion + 1
            if initQuestion == questVotes.count - 1 {
                nextQuestion.isHidden = true
                nextQuestionBtn.isHidden = true
            }
            questionsTxt.text = questVotes[initQuestion].question
            var ansInd = 0
            for ind in 0..<questionAnsContainer.subviews.count {
                if ind % 2 == 0 {
    (questionAnsContainer.subviews[ind] as! UILabel).text = questVotes[initQuestion].questionAnswer[ansInd].answerTitle
                    ansInd = ansInd + 1
                } else {
                    continue
                }
            }
            
        }
       
            }
    
    //MARK:- RadioButtonsSelection
    
    @objc func labelChoiseFunc(sender:UIGestureRecognizer) {//UIGestureRecognizer
        //  guard let TagRe = (sender.view as? UILabel)?.text else { return }
        guard let tag = (sender.view as? UILabel)?.tag else { return }
        for ind in 0..<questionAnsContainer.subviews.count {
            print("the \(ind) is :")

            print(questionAnsContainer.subviews[ind])
            if ind % 2 == 1 {
                print(ind)
                print(questionAnsContainer.subviews[ind])
                (questionAnsContainer.subviews[ind] as! UIButton).isSelected = false
            } else {
                continue
            }
        }

     /*
        for ind in 2..<questionAnsContainer.subviews.count {
            if ind % 2 == 1 {
                print(ind)
                print(questionAnsContainer.subviews[ind])
                (questionAnsContainer.subviews[ind] as! UIButton).isSelected = false
            } else {
                continue
            }
        } */
        (questionAnsContainer.viewWithTag(tag * 2) as? UIButton)!.isSelected = true
        answerSelect = questVotes[initQuestion].questionAnswer[tag - 1].answerID
        answerSelectTitle = questVotes[initQuestion].questionAnswer[tag - 1].answerTitle
        print(answerSelect)
        print(answerSelectTitle)
        print(tag - 1)
        //  performSegue(withIdentifier: "newsdetail", sender: topNewsList[tag - 1]) //topNewsList[]
    }
    
    
    @objc func butClic (_ sender: UIButton){
        for ind in 1..<questionAnsContainer.subviews.count {
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
        let buTitleInt = (sender.tag / 2 ) - 1
        //appointmentSelect = appointmentBooking[buTitleInt]
       // appointmentSelect = availableAppointmentList[buTitleInt].appoimentID
       // appointmentSelect_Name = availableAppointmentList[buTitleInt].appoimentName
       // questVotes[initQuestion].questionAnswer[f]
        answerSelect = questVotes[initQuestion].questionAnswer[buTitleInt].answerID
        answerSelectTitle = questVotes[initQuestion].questionAnswer[buTitleInt].answerTitle
        print(answerSelect)
        print(answerSelectTitle)
    }
    

    @objc func butClicOld (_ sender: UIButton){
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
    
    //MARK:- SpeakerNextBackButtons
    @IBAction func nextSpeakerMethod(_ sender: Any) {
        if speakerCounterIndex < speakerList.count - 1 {
            print(speakerCounterIndex)
            speakerCounterIndex = speakerCounterIndex + 1
            backSpeakerBtnImg.isHidden = false
            backSpeakerBtn.isHidden = false
            if speakerCounterIndex == speakerList.count - 1 {
                nextSpeakerBtn.isHidden = true
                nextSpeakerBtnImg.isHidden = true
            }
            
        } else if speakerCounterIndex == speakerList.count - 1 {
            backSpeakerBtnImg.isHidden = false
            backSpeakerBtn.isHidden = false
            nextSpeakerBtn.isHidden = true
            nextSpeakerBtnImg.isHidden = true
        }
        if !(speakerList.isEmpty) { // != nil
            speakerName.text = speakerList[speakerCounterIndex].name
            speakerJobTitle.text = speakerList[speakerCounterIndex].jobTitle
           // imgUrl(imgUrl: speakerList[speakerCounterIndex].speakerImageUrl!)
            Helper.loadImagesKingFisher(imgUrl: speakerList[speakerCounterIndex].speakerImageUrl!, ImgView: speakerProfile)

        }
    }
    
    @IBAction func backSpeakerMethod(_ sender: Any) {
        if speakerCounterIndex > 0   {
            print(speakerCounterIndex)
            speakerCounterIndex = speakerCounterIndex - 1
            nextSpeakerBtn.isHidden = false
            nextSpeakerBtnImg.isHidden = false
            if speakerCounterIndex == 0 {
                backSpeakerBtnImg.isHidden = true
                backSpeakerBtn.isHidden = true
            }
            
        } else if speakerCounterIndex == 0 {
            backSpeakerBtnImg.isHidden = true
            backSpeakerBtn.isHidden = true
            nextSpeakerBtn.isHidden = false
            nextSpeakerBtnImg.isHidden = false
        }
        if !(speakerList.isEmpty) { // != nil
        speakerName.text = speakerList[speakerCounterIndex].name
        speakerJobTitle.text = speakerList[speakerCounterIndex].jobTitle
            Helper.loadImagesKingFisher(imgUrl: speakerList[speakerCounterIndex].speakerImageUrl!, ImgView: speakerProfile)

        //imgUrl(imgUrl: speakerList[speakerCounterIndex].speakerImageUrl!)
        }
      
//cashe image needed
        
    }
    //MARK:- AskSpeakerMethods

    @IBAction func sendQuestionBtn(_ sender: Any) {
        let questionTextSend = questionTxt.text
        if questionTextSend?.trimmed == "" || questionTextSend == nil {
            let alert = UIAlertController(title: "oPP's!", message: "You didn't write your question!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let questionCheckParam : Parameters =
                ["sessionID": "\((self.singleItem?.agenda_ID)!)",
                    "speakerID": "\((speakerList[speakerCounterIndex].speaker_id)!)",
                    "question": "\((questionTextSend)!)"]
            OpenSessionVC.likeFlag = "faveMethod"
            Service.postServiceWithAuth(url: URLs.askQuestion, parameters: questionCheckParam) {
                (response) in
                print(response)
                if response == nil {
                    OpenSessionVC.likeFlag = ""
                    self.questionTxt.text = ""
                    let alert = UIAlertController(title: "Succes!", message: "your question is send!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
             //        self.sendQuestMainContainer.isHidden = true
                }
            }
            
        }
     
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
    
    @IBAction func dismissContainer(_ sender: Any) {
        sendQuestMainContainer.isHidden = true
        hideKyebad()
        
    }
    
    @IBAction func vote(_ sender: Any) {
        
        if let  apiToken  = Helper.getApiToken() {
            if initQuestion == nil || answerSelect == nil || answerSelect == "" {
                let alert = UIAlertController(title: "oPP's!", message: "You didn't select the answer!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                let questionCheckParam : Parameters =
                    ["sessionID": "\((self.singleItem?.agenda_ID)!)",
                        "questionID":  (questVotes[initQuestion].questionsID)!,
                        "answerID": answerSelect!]
                OpenSessionVC.likeFlag = "faveMethod"
                
                Service.postServiceWithAuth(url: URLs.voteAnswerQuesiton, parameters: questionCheckParam) {
                    (response) in
                    print(response)
                    if response == nil {
                        OpenSessionVC.likeFlag = ""
                        self.questionTxt.text = ""
                        let alert = UIAlertController(title: "Succes!", message: "your question is send!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        //        self.sendQuestMainContainer.isHidden = true
                        
                    }
                }
                
            }        } else {
            let alert = UIAlertController(title: "Not Available", message: "You must at first sign in!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
      
    }
    
    //MARK:- NavTOSpeakerProfile
    @objc func speakerDetailLabel(sender:UIGestureRecognizer) {
      /*  guard let tag = (sender.view as? UILabel)?.tag else {
            // return
            //   let tag = (sender.view as? UIImageView)?.tag
            return
        } */
        
        performSegue(withIdentifier: "sessionspeakerdetail", sender: speakerList[speakerCounterIndex])
        
    }
    
    @objc func speakerDetailImg(sender:UIGestureRecognizer) {
     /*   guard let tag = (sender.view as? UIImageView)?.tag else {
            return
        } */
        performSegue(withIdentifier: "sessionspeakerdetail", sender: speakerList[speakerCounterIndex])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let speak = segue.destination as? SpeakerProfileVC {
            if let favDetail = sender as? Speakers {
                speak.singleItem = favDetail
            }
        }
    }
    
    //MARK:- Show/Hide Views

    func noSpeakerMethod()  {
        speakerViewContainer.isHidden = true
        describtionTopConstraint.constant = -(speakerViewContainer.frame.height) + 10
        describeHeightConstraints.constant = (describeHeightConstraints.constant) + (speakerViewContainer.frame.height)
     //   describtionContainerView.frame.height =  describtionContainerView.frame.height + speakerViewContainer.frame.height
    }
    
    func noDescribtionMethod()  {
        //
        describtionContainerView.isHidden = true
        questionContTopConstraint.constant = -(describtionContainerView.frame.height)
    }
    
    func noQuestionMethod()  {
        questionVoteContainer.isHidden = true
        describeHeightConstraints.constant = (describeHeightConstraints.constant) + (questionVoteContainer.frame.height)
    }
    
    
    //MARK:- Favourite/Un Buttons

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
        }
        else {
            let alert = UIAlertController(title: "Error", message: "You must sign in to Show this Part", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
          //  dismiss(animated: true, completion: nil)
        }
    }
    
}

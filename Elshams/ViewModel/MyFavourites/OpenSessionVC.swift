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

class OpenSessionVC: UIViewController {
    static var AgednaOrFavourite:Bool = true
    var singleItem:ProgramAgendaItems?
    var quest = Array<QuestionsData>()
    var answerSelect:String?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // nextQuestion.ges
        loadSessionData(SessionID: (singleItem?.agenda_ID)!)
        if  OpenSessionVC.AgednaOrFavourite == true {
            self.navigationItem.title = "Agenda"

        } else {
            self.navigationItem.title = "My Favourite"

        }
       

    }
    
    func loadSessionData(SessionID:String)  {
       // if user logIN Authorize use this
        /*   Service.getServiceWithAuth(url: "http://66.226.74.85:4002/api/Event/getSessionDetails/\((self.singleItem?.agenda_ID)!)") {
         (response) in
         print("this is favour ")
         print(response)
         }
         */
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
        // get speakers
        let speaker_all = result["Speaker"]["AllSpeaker"]
        self.speaker_ID = speaker_all[0]["ID"].string
        self.speaker_Name = speaker_all[0]["name"].string
        self.speaker_JobTitle = speaker_all[0]["jobTitle"].string
        self.speaker_CompanyName = speaker_all["companyName"].string
        self.speaker_ImageUrl = speaker_all[0]["imageUrl"].string
        self.speaker_About = speaker_all[0]["about"].string
        self.speaker_ContectInforamtion = speaker_all[0]["ContectInforamtion"].dictionaryObject
        self.speaker_Email = speaker_all[0]["ContectInforamtion"]["Email"].string
        self.speaker_Linkedin = speaker_all[0]["ContectInforamtion"]["linkedin"].string
        self.speaker_Phone = speaker_all[0]["ContectInforamtion"]["phone"].string
        
        let contect = ["Email": "",
                       "linkedin": "",
                       "phone": ""]
 
        let questions_all = result["Question"]["AllQuestion"]
        print("this is question")
        print(questions_all)
        self.question_ID = questions_all["ID"].string
        self.question_head = questions_all["question"].string
        self.question_answer = questions_all["answer"].string
        self.question_TimeStamp = questions_all["questionTimeStamp"].string
        self.speakerList.removeAll()
        self.questionList.removeAll()
        self.sessionList.removeAll()
        
        self.speakerList.append(Speakers(SpeakerName: self.speaker_Name ?? "name", JobTitle: self.speaker_JobTitle ?? "JOB", CompanyName: self.speaker_CompanyName ?? "Company", SpImageUrl: self.speaker_ImageUrl ?? "Image", Speaker_id: self.speaker_ID ?? "ID", ContectInforamtion: self.speaker_ContectInforamtion ?? contect, About: self.speaker_About ?? "About"))
        self.questionList.append(QuestionsData(Questions: self.question_head ?? "question", Answer: self.question_answer ?? "answer", QuestionsID: self.question_ID ?? "ID", QuestionTimeStamp: self.question_TimeStamp ?? "TimeStamp"))
        
        self.sessionList.append(ProgramAgendaItems(Agenda_ID: self.session_ID ?? "ID", SessionTitle: self.session_Title ?? "Title", SessionTime: self.session_Time ?? "Time", SessionLocation: self.session_Location ?? "location", SpeakersSession:  [
            "ID" : "314",
            "imageUrl" : "http:-b01d-582382a5795e.jpg"]
            , AgendaDate: self.session_Date ?? "date", FavouriteSession: self.session_isFavourate ?? true , FavouriteSessionStr: self.session_isFavourate_Str ?? "true" , RondomColor: self.session_RondomColor ?? "red", AgendaType: self.session_Type ?? "session"))
        
        
        if self.session_isFavourate == true {
            self.favouriteIcon.image = UIImage(named: "like-session")
        }else {
            self.favouriteIcon.image = UIImage(named: "unlike-session")
        }
        self.mangeSessionDetails(SeseionTitle: self.session_Title ?? "Title", AgendaDate: self.session_Date ?? "date", SessionTime:  self.session_Time ?? "Time", SessionLocation: self.session_Location ?? "location", SessionDescribtion: self.session_Description ?? "Describition", SpeakerName: self.speaker_Name ?? "name", SpeakerJobTitle: self.speaker_JobTitle ?? "JOB", SpeakerImgUrl: self.speaker_ImageUrl ?? "Image", QestionHead: self.question_head ?? "question")
        }
        
    }
    
    func imgUrl(imgUrl:String)  {
        if let imagUrlAl = imgUrl as? String {
            Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                print(response)
                if let image = response.result.value {
                    DispatchQueue.main.async{
                        self.speakerProfile.image = image
                    }
                }
            })
        }
    }
    
    func mangeSessionDetails(SeseionTitle:String,AgendaDate:String,SessionTime:String,SessionLocation:String,SessionDescribtion:String,SpeakerName:String,SpeakerJobTitle:String,SpeakerImgUrl:String,QestionHead:String){
 
        
         sessionTitle.text = SeseionTitle
         sessionDate.text = AgendaDate
         sessionTime.text = SessionTime
         sessionLocation.text = SessionLocation
         eventDescribtion.text = SessionDescribtion
      
         speakerName.text = SpeakerName
         speakerJobTitle.text = SpeakerJobTitle
         imgUrl(imgUrl: SpeakerImgUrl)
        
        speakerProfile.layer.cornerRadius = speakerProfile.frame.width / 2
        speakerProfile.clipsToBounds = true
        viewFavBack.layer.cornerRadius = viewFavBack.frame.width / 2
        viewFavBack.clipsToBounds = true
        
        questionsTxt.text = QestionHead
        
   /*     for i in 0..<1{
              for i in 0..<questionList.count{
            var qu = Int(questionList[i].answerArr!.count)
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
        */
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
        //quest[num]
       // answerSelect = quest[initQuestion].answerArr?[buTitleInt]
        print(answerSelect)

    }
    @IBAction func askSpeaker(_ sender: Any) {
    }
    
    @IBAction func vote(_ sender: Any) {
    }
    
    @IBAction func btnFavouriteSession(_ sender: Any) {
     /*   if self.session_isFavourate == true {
            }
            */
        let sessionFavID : Parameters = ["sessionID" : "\((self.singleItem?.agenda_ID)!)"]
       // let urlA  = "http://66.226.74.85:4002/api/Event/favourateAction"
      //  let head : HTTPHeaders = ["Authorization": "Bearer wEJa4fD25FJ7W0zZd7STelBmOARPdCuPl9uzzwFFTOI9jmbLbLo4dzrxlp3RTMzIKc-tJeEqeQTtvd9QO00wxCqi1YU73FlVr5LZblfdysFyTgtIMdVHilmjv_Noz5jnXkcaKTNUTcMY20kpaF69ezMzEg8GQY_Ni1HkwdZNww9O6_ueRNZaP08fLInE3LVuFnKChKYGGAlHSDgiRAhcTkBO2AWMPzKYavXcEHZz6d1myYHRsHiXB-BF96ieMxzOM_2LlxXAWG4gvGGj46lAEmEBVGDRksKGmLCQl1JMMH5qnQ8Zth2FoT_Vj1-DQPiHkSJA8tDl-CtaR4_K3U73-KP3UJ7iHDzGt7Pr1nvlMI9LXgkuFcxM2cw4WlqrwgSywxENP6x41JqKVo5UDjiEH7eH5NuBWftAjasp4XeaKsRuNmEY6U2z3hjgUzXHpHtc","Content-Type": "application/json"]
        
            if self.session_isFavourate == true {
                Service.postServiceWithAuth(url: URLs.unfavourateAction, parameters: sessionFavID) {
                    (response) in
                    print(response)
                    let result = JSON(response)
           self.session_isFavourate = false
            self.session_isFavourate_Str = "false"
                    self.favouriteIcon.image = UIImage(named: "unlike-session")
                  /*  Service.getServiceWithAuth(url: "http://66.226.74.85:4002/api/Event/getSessionDetails/\((self.singleItem?.agenda_ID)!)") {
                    //  Service.getService(url: "http://66.226.74.85:4002/api/Event/getSessionDetails/374") {
                        (response) in
                        print("this is UNfavour ")
                        print(response)
                    }  */
                 
        }
            }
                else {
              /*  Alamofire.request("http://66.226.74.85:4002/api/Event/favourateAction", method: .post, parameters: sessionFavID, encoding: JSONEncoding.default, headers: head )
                    .validate(statusCode: 200..<600)
                    .responseJSON { response in */
            Service.postServiceWithAuth(url: URLs.favourateAction, parameters: sessionFavID) {
                (response) in
                    /*    print ("the response is : ")
                        print(response.request)  // original URL request
                        print(response.response) // HTTP URL response
                        print(response.data)     // server data
                        print(response.result)   // result of response serialization
*/
                print(response)
                let result = JSON(response)
             /*   Service.getServiceWithAuth(url: "http://66.226.74.85:4002/api/Event/getSessionDetails/\((self.singleItem?.agenda_ID)!)") {
                    (response) in
                    print("this is favour ")
                    print(response)
                }
                */
            }
            favouriteIcon.image = UIImage(named: "like-session")
            self.session_isFavourate = true
            self.session_isFavourate_Str = "true"
                
           // AgendaVC.agendaList[singleItem.id]
        }
    }
    
}
//}


// sessionTitle.text = sessionList[0].seseionTitle
//   sessionDescribtion.text = sessionList[0].
//     let speakerSingleFilter = SpeakersVC.speakerList[(singleItem?.speaker_FK_Id)!]
/* let filterspeaker = SpeakersVC.speakerList.filter { (($0.speaker_id_str!.contains((singleItem?.speaker_FK_Id_Str)!)))} */
//   let filtFirst = filterspeaker.first

//  let speakerSingle = SpeakersVC.speakerList[(singleItem?.speaker_FK_Id)!]
//speakerProfile.image = UIImage(named: speakerSingle.speakerImage!)
/*  speakerName.text = filtFirst?.name
speakerProfile.image = UIImage(named: (filtFirst?.speakerImage)!)
speakerJobTitle.text = filtFirst?.jobTitle */


/*  quest.append(QuestionsData(Questions: "What is the chiefly responsible for the increase in the average length of life in USA during the last fifty years?", Answer: "b", AnswerArr: ["a.the reduced death rate among infants.","b.The subistituation of machine for human","c.Compulsory health and physical education."], IdQuset: 0))
 
 quest.append(QuestionsData(Questions: "What is the chiefly responsible for the increase in the average length of life in USA during the last thirty years?", Answer: "a", AnswerArr: ["a.Compulsory health and physical education.","b.the reduced death rate among infants.","c.The subistituation of machine for human"], IdQuset: 1))
 quest.append(QuestionsData(Questions: "What is the chiefly responsible for the increase in the average length of life in USA during the last seventy years?", Answer: "c", AnswerArr: ["a.The subistituation of machine for human","b.Compulsory health and physical education.","c.the reduced death rate among infants."], IdQuset: 2))

 print("count of answer arr \(quest[0].answerArr?.count)")

 */

//
//  Config.swift
//  Elshams
//
//  Created by mac on 1/28/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import SwiftyJSON
import  UIKit
import Alamofire

struct URLs {
    static let main = "http://68.168.111.23:9603/api"
  //static let main = "http://68.168.111.23:9700/api"

    static let login = main + "/account/Login"
    static let register = main + "/account/register"
    static let getSettingData = main + "/Event/getpofile"
    static let updateSettingData = main + "/Event/updateProfile"
    static let getNetwork = main + "/Event/getNetwork"
    static let getPersonDetails = main + "/Event/getPersonDetails"
    
    static let getNews = main + "/Event/GetHome"
    // have item number and page number some issue that don't resposne page numers and current number

    static let getAgenda = main + "/Event/getAgenda"

    static let askQuestion = main + "/Event/askQuestion"

    static let getAllSpeaker = main + "/Event/getAllSpeaker" 
     static let getSpeakerDetail = main + "/Event/GetSpeakerDetail"
    static let getAllSponsors = main + "/Event/getAllSponsors"
    
    static let getAllStartups = main + "/Event/getAllStartups"
    static let getInnovation = main + "/Event/getInnovation"
    static let voteAnswerQuesiton = main + "/Event/answerQuesiton"

    
    static let getCyberSecurity = main + "/Event/getCyberSecurity"
    static let getDigitalMarketing = main + "/Event/getDigitalMarketing"
    static let getAllExhibitors = main + "/Event/getAllExhibitors"

    static let askStartupExhibtorQuestion = main + "/Event/AddQuestionToExhibitors"
    static let getQuestionsStratupExhibitors = main + "/Event/getQuestions_Stratup_Exhibitors"



    static let getStartupDetailsByID = main + "/Event/getStartupDetailsByID"
    static let getExhibitorDetailsByID = main + "/Event/getExhibitorDetailsByID"
    static let getInnovationSessionDetailsByID = main + "/Event/getInnovationSessionDetails"
    static let getCyberSecuritySessionDetails = main + "/Event/getCyberSecuritySessionDetails"
    static let getDigitalMarketingSessionDetails = main + "/Event/getDigitalMarketingSessionDetails"



    static let getAvaliableAppoiments = main + "/Event/getAvaliableAppoiments"
    static let getAppoiments = main + "/Event/getAppoiments"
    static let requestAppoiment = main + "/Event/requestAppoiment"

    
    static let getAllfavourate = main + "/Event/getAllfavourate"
    static let getSessionDetails = main + "/Event/getSessionDetails"
    static let getFavoriteSessionDetail = main + "/Event/getFavoriteSessionDetails"

    static let getQuestions = main + "/Event/getQuestions"
    static let getAllNotification = main + "/Event/getAllNotification"

    static let favourateAction = main + "/Event/favourateAction"
    static let unfavourateAction = main + "/Event/unfavourateAction"
   
    static let getAllPosts = main + "/Event/getAllPosts"
    static let addUnLikeTopost = main + "/Event/AddUnLikeTopost"
    static let addLikeTopost = main + "/Event/AddLikeTopost"

    static let getAbout = main + "/Event/getAbout"



    
    static let headerAuth : HTTPHeaders = ["Authorization": "Bearer \((Helper.getApiToken())!)"]
    
    
}

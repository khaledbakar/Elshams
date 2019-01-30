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
    static let login = main + "/account/Login"
    static let register = main + "/account/register"
    static let getNetwork = main + "/Event/getNetwork"
    static let getPersonDetails = main + "/Event/getPersonDetails"

    static let getAgenda = main + "/Event/getAgenda"
    static let getAllSpeaker = main + "/Event/getAllSpeaker"
    static let getAllSponsors = main + "/Event/getAllSponsors"
    
    static let getAllStartups = main + "/Event/getAllStartups"
    static let getStartupDetailsByID = main + "/Event/getStartupDetailsByID"
    static let getAvaliableAppoiments = main + "/Event/getAvaliableAppoiments"
    static let getAppoiments = main + "/Event/getAppoiments"
    static let requestAppoiment = main + "/Event/requestAppoiment"

    
    static let getAllfavourate = main + "/Event/getAllfavourate"
    static let getSessionDetails = main + "/Event/getSessionDetails"
    static let getQuestions = main + "/Event/getQuestions"
    static let getAllNotification = main + "/Event/getAllNotification"

    static let favourateAction = main + "/Event/favourateAction"
    static let unfavourateAction = main + "/Event/unfavourateAction"
   
    static let getAllPosts = main + "/Event/getAllPosts"


    
    static let headerAuth : HTTPHeaders = ["Authorization": "Bearer \((Helper.getApiToken())!)"]
    
}

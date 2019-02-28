//
//  API.swift
//  Elshams
//
//  Created by mac on 1/28/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON

class API: NSObject {
    static let reachabilityManager = NetworkReachabilityManager(host: "https://baseURL.com")!

    
    static func getPostsWithAuth(url: String,newsFeedList: [NewsFeedData] ,callback: @escaping (JSON?) -> ()) {
     //  newsFeedList.enumerated()
     //   newsFeedList.removeAll()
        //newsFeedList.removeAll()
//newsFeedList.removeAll()
        //i tried to use return array but alamofire out of return and back again so nil
        // tried to pass param array  but an strange error 
        if !reachabilityManager.isReachable {
            callback(nil)
            
        } else {
       
            Alamofire.request(url, headers: URLs.headerAuth).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let result = json["AllPosts"]
                    var iDNotNull = true
                    var index = 0
                    while iDNotNull {
                        let post_ID = result[index]["ID"].string
                        if post_ID == nil || post_ID?.trimmed == "" || post_ID == "null" || post_ID == "nil" {
                            iDNotNull = false
                            break
                        }
                        let post_Author = result[index]["author"].string
                        let post_AutherPic = result[index]["autherPic"].string
                        let post_VedioURl = result[index]["vedioURl"].string
                        let post_Discription = result[index]["postDiscription"].string
                        let post_LikeCount = result[index]["about"].int
                        let post_Comments = result[index]["Comments"].array
                        let post_Islike = result[index]["Islike"].bool
                        let post_SharingLink = result[index]["sharingLink"].string
                        let post_Image = result[index]["image"].string
                      //  newsFeedList.append(NewsFeedData(Post_ID: post_ID ?? "", Post_Author: post_Author ?? "", Post_AutherPicture: post_AutherPic ?? "", Post_VideoURl: post_VedioURl ?? "" , Post_Discription: post_Discription ?? "", Post_LikeCount: post_LikeCount ?? 0, Post_Comments: post_Comments ?? [result], Post_Islike: post_Islike ?? false, Post_SharingLink: post_SharingLink ?? "", Post_Image: post_Image ?? ""))
                        index = index + 1
                   //     self.timeLineCollView.reloadData()
                    }
                    callback(json)
                case .failure(let error):
                    print(error)
                    callback(nil)
                }
            }
        }
    }
    
    
    
    
    class func login(Email:String, Password:String, completion: @escaping (_ error:Error?, _ succes: Bool)->Void){
      
        let paramLogin : [String:Any] = [
            "Email" : Email,
            "Password" : Password]
        
        Service.postService(url: URLs.login, parameters: paramLogin){ (response) in
            print("This is response request : ")
            print(response)
            let json = JSON(response)
            if let error = json["error"].string {
                let error_description = json["error_description"].string
                NotificationCenter.default.post(name: NSNotification.Name("LoginError"), object: nil)

              print(error_description)
            } else {
                if let apiToken = json["access_token"].string {
                    print("api token \(apiToken)")
                    Helper.saveApiToken(Token: apiToken)
                    //      completion(nil , true)
                }
            }
          
        }
        
     /*   Alamofire.request(URLs.login, method: .post, parameters: paramLogin, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result
                {
                    case .failure(let error):
                        completion(error,false)
                    print(error)
                case .success(let value):
                    let json = JSON(value)
                    if let apiToken = json["access_token"].string {
                        print("api token \(apiToken)")
                        Helper.saveApiToken(Token: apiToken)
                        completion(nil , true)
                    }
                }
        } */
    }
    
    class func register(Email:String, Password:String, Title:String, CompanyName:String,
                        JobTitle:String, About:String, Phone:String,Picture:String,Linkedin:String,
                        completion: @escaping (_ error: Error?, _ succes: Bool)->Void){
        
        let paramRegister : [String:Any] = [
            "Email" : Email,
            "password" : Password,
            "Title" : Title, //title name and about and company name no field for it
            "CompanyName" : CompanyName,
            "jobTitle" : JobTitle,
            "about" : About,
            "phone" : Phone,
            "picture" : Picture,
            "linkedin" : Linkedin
        ]
        print(URLs.register)
        Service.postService(url: URLs.register, parameters: paramRegister){ (response) in
            print("This is response request : ")
            print(response)
            let json = JSON(response)
            
            if let apiToken = json["access_token"].string {
                print("api token \(apiToken)")
                 NotificationCenter.default.post(name: NSNotification.Name("SuccesRegister"), object: nil)
                Helper.saveApiToken(Token: apiToken)
          //      completion(nil , true)
       
            } else {
                
                let messageError = json["Message"].string
                RegisterationVC.registerError = messageError
                NotificationCenter.default.post(name: NSNotification.Name("ErrorConnections"), object: nil)

                
            }
           
            /*  Alamofire.request(URLs.register, method: .post, parameters: paramRegister, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                switch response.result
                {
                  case .failure(let error):
                    completion(error,false)
                    print(error)
                  case .success(let value):
                    let json = JSON(value)
                    if let apiToken = json["access_token"].string {
                        print("api token \(apiToken)")
                        Helper.saveApiToken(Token: apiToken)
                        completion(nil , true)
                    }
                }
        } */
    }
}
    
    class func updateUserData(Email:String, Password:String, Title:String, CompanyName:String,
                              JobTitle:String, About:String, Phone:String,Picture:String,Linkedin:String,Ispublic:String,
                        completion: @escaping (_ error: Error?, _ succes: Bool)->Void){
        
        let paramRegister : [String:Any] = [
            "Title" : Title,
            "jobTitle" : JobTitle,
            "companyName" : CompanyName, //title name and about and company name no field for it
            "picture" : Picture,
            "email" : Email,
            "password" : Password,
            "linkedin" : Linkedin,
            "phone" : Phone,
            "about" : Linkedin,
            "isPublic" : Ispublic

        ]
       /* "Title": "biveloLKperikd",
        "jobTitle": "biz developer",
        "companyName": "biz developer",
        "picture": "",
        "email": "msa@gmail.com",
        "linkedin": "aass",
        "phone": "01023029394993",
        "about": "biz developer",
        "isPublic": "True"
        */

        Service.postServiceWithAuth(url: URLs.updateSettingData, parameters: paramRegister){ (response) in
            print("This is response request : ")
            print(response)
            let json = JSON(response)
            let message = json["message"].string  //   "message" : "Updated"

            let messageError = json["Message"].string

            // in activity
            if messageError == nil || messageError == ""{
                SettingsVC.udapatedMessage = message! //  "Message" : "An error has occurred." setting error

                NotificationCenter.default.post(name: NSNotification.Name("SuccesUpdate"), object: nil)
                Helper.loadUserData()
            }
            else {
                SettingsVC.udapatedMessage = messageError! //  "Message" : "An error has occurred." setting error

                NotificationCenter.default.post(name: NSNotification.Name("ErrorConnections"), object: nil)

            }

        
        }
    }
}

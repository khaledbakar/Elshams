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
    class func login(Email:String, Password:String, completion: @escaping (_ error:Error?, _ succes: Bool)->Void){
      
        let paramLogin : [String:Any] = [
            "Email" : Email,
            "Password" : Password]
        
        Service.postService(url: URLs.login, parameters: paramLogin){ (response) in
            print("This is response request : ")
            print(response)
            let json = JSON(response)
            if let apiToken = json["access_token"].string {
                print("api token \(apiToken)")
                Helper.saveApiToken(Token: apiToken)
                //      completion(nil , true)
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
                Helper.saveApiToken(Token: apiToken)
          //      completion(nil , true)
        }       /*  Alamofire.request(URLs.register, method: .post, parameters: paramRegister, encoding: URLEncoding.default, headers: nil).responseJSON { response in
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
}

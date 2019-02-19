 //
//  Helper.swift
//  Elshams
//
//  Created by mac on 1/28/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
 import  Alamofire
 import AlamofireImage
 import SwiftyJSON
 import Kingfisher
 
 class Helper: NSObject {
    
    
   class func  loadUserData()  {
        if let  apiToken  = Helper.getApiToken() {
            Service.getServiceWithAuth(url: URLs.getSettingData){
                (response) in
                print(response)
                let result = JSON(response)
                let user_Name = result["Title"].string
                let user_JobTitle = result["jobTitle"].string
                let user_CompanyName = result["companyName"].string
                let user_ImageUrl = result["picture"].string
                let user_Password = result["password"].string
                let user_Email = result["email"].string
                let user_Linkedin = result["linkedin"].string
                let user_Phone = result["phone"].string
                let user_about = result["about"].string
                let user_Ispublic_str = result["isPublic"].string
                
                let settingUserData : [String] = [user_Email ?? "",user_Password ?? "",user_JobTitle ?? "",user_Phone ?? "",user_about ?? "",user_Name ?? "",user_CompanyName ?? "",user_Linkedin ?? "",user_ImageUrl ?? ""]
                
                Helper.saveSettingUserData(UserData: settingUserData)
                Helper.saveUserName(UserName: user_Name!)
                Helper.saveUserImageUrl(UserProfileUrl: user_ImageUrl!)
                Helper.saveUserJobTitle(UserJobTitle: user_JobTitle!)
           
            }
        }
    }
    
    class func restartApp() {
        guard let window = UIApplication.shared.keyWindow else { return }
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var  vc : UIViewController
        
        if getApiToken() == nil {
            vc = sb.instantiateInitialViewController()!
        } else {
            
            loadUserData()
            vc = sb.instantiateViewController(withIdentifier: "NavTimeLine")
        }
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
    class func loadImagesKingFisher(imgUrl:String,ImgView:UIImageView)  {
    if imgUrl == nil || imgUrl == "" {
        ImgView.image = UIImage(named: "home-logo")

    } else {
    ImgView.kf.indicatorType = .activity
    if let url = URL(string: imgUrl) {
    ImgView.kf.setImage(with: url, placeholder: nil, options: [.transition(ImageTransition.fade(0.5))], progressBlock: nil, completionHandler: nil)
           }
        }
     }
   
    class func saveApiToken(Token:String) {
        let def = UserDefaults.standard
        def.setValue(Token, forKey: "api_token")
        def.synchronize()
        restartApp()
    }
    
    class func saveSettingUserData(UserData:[String]) {
        let def = UserDefaults.standard
        def.setValue(UserData, forKey: "user_data")
        def.synchronize()
       // restartApp()
    }
    
    class func getSettingUserData() -> [String]? {
        let def = UserDefaults.standard
        return def.object(forKey: "user_data") as? [String]
        
    }
    
    class func saveUserName(UserName:String) {
        let def = UserDefaults.standard
        def.setValue(UserName, forKey: "user_name")
        def.synchronize()
        // restartApp()
    }
    class func getUserName() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "user_name") as? String
        
    }
    
    class func saveCITAbout(CITAbout:String) {
        let def = UserDefaults.standard
        def.setValue(CITAbout, forKey: "cit_about")
        def.synchronize()
        // restartApp()
    }
    class func getCITAbout() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "cit_about") as? String
        
    }
    
    class func saveUserJobTitle(UserJobTitle:String) {
        let def = UserDefaults.standard
        def.setValue(UserJobTitle, forKey: "user_jobtitle")
        def.synchronize()
        // restartApp()
    }
    class func getUserJobTitle() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "user_jobtitle") as? String
        
    }
    
    class func saveUserImageUrl(UserProfileUrl:String) {
        let def = UserDefaults.standard
        def.setValue(UserProfileUrl, forKey: "user_profileurl")
        def.synchronize()
        // restartApp()
    }
    class func getUserImageUrl() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "user_profileurl") as? String
        
    }
    
    
    class func saveUserImage(UserProfile:UIImage) {
        let def = UserDefaults.standard
        def.setValue(UserProfile, forKey: "user_profile")
        def.synchronize()
        // restartApp()
    }
    class func getUserImage() -> UIImage? {
        let def = UserDefaults.standard
        return def.object(forKey: "user_profile") as? UIImage
        
    }
    
    class func getApiToken() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "api_token") as? String

    }
 }

 
 
 /*  class func imgUrl(imgUrl:String)  {
  // if  TimeLineHomeVC.failMessage !=  "fail"{
  if let imagUrlAl = imgUrl as? String {
  Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
  print(response)
  switch response.result {
  case .success(let value):
  if let image = response.result.value {
  DispatchQueue.main.async{
  //    if let apiToken = json["access_token"].string {
  //        print("api token \(apiToken)")
  Helper.saveUserImage(UserProfile: image)
  //      completion(nil , true)
  //   }
  //   self.userProfile.image = image
  }
  }
  
  case .failure(let error):
  print(error)
  
  }
  })
  }
  // }
  }
  
  */

 //
//  Helper.swift
//  Elshams
//
//  Created by mac on 1/28/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
 class Helper: NSObject {
    class func restartApp() {
        guard let window = UIApplication.shared.keyWindow else { return }
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var  vc : UIViewController
        
        if getApiToken() == nil {
            vc = sb.instantiateInitialViewController()!
        } else {
            vc = sb.instantiateViewController(withIdentifier: "NavTimeLine")
        }
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
    class func saveApiToken(Token:String) {
        let def = UserDefaults.standard
        def.setValue(Token, forKey: "api_token")
        def.synchronize()
        restartApp()
    }
    
    class func getApiToken() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "api_token") as? String

    }
 }

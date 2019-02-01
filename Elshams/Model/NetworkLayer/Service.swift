//
//  Service.swift
//  Elshams
//
//  Created by mac on 1/13/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Service: NSObject {
    
    static let reachabilityManager = NetworkReachabilityManager(host: "https://baseURL.com")!
    
    // GET Services
    static func getService(url: String, callback: @escaping (JSON?) -> ()) {
        
        if !reachabilityManager.isReachable {
            callback(nil)
            
        } else {
            Alamofire.request(url).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    callback(json)
                case .failure(let error):
                    print(error)
                    
                    callback(nil)
                }
            }
        }
    }
    
    static func getServiceWithAuth(url: String, callback: @escaping (JSON?) -> ()) {
        
        if !reachabilityManager.isReachable {
            callback(nil)
            
        } else {
            //put token value here
            let header : HTTPHeaders = ["Authorization": "Bearer wEJa4fD25FJ7W0zZd7STelBmOARPdCuPl9uzzwFFTOI9jmbLbLo4dzrxlp3RTMzIKc-tJeEqeQTtvd9QO00wxCqi1YU73FlVr5LZblfdysFyTgtIMdVHilmjv_Noz5jnXkcaKTNUTcMY20kpaF69ezMzEg8GQY_Ni1HkwdZNww9O6_ueRNZaP08fLInE3LVuFnKChKYGGAlHSDgiRAhcTkBO2AWMPzKYavXcEHZz6d1myYHRsHiXB-BF96ieMxzOM_2LlxXAWG4gvGGj46lAEmEBVGDRksKGmLCQl1JMMH5qnQ8Zth2FoT_Vj1-DQPiHkSJA8tDl-CtaR4_K3U73-KP3UJ7iHDzGt7Pr1nvlMI9LXgkuFcxM2cw4WlqrwgSywxENP6x41JqKVo5UDjiEH7eH5NuBWftAjasp4XeaKsRuNmEY6U2z3hjgUzXHpHtc"] // Customize it as needed
            Alamofire.request(url, headers: URLs.headerAuth).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    callback(json)
                case .failure(let error):
                    print(error)
                    callback(nil)
                }
            }
        }
    }
    //image
 /*   static func imgUrl(imgUrl:String,imageSet:UIImage)  {
        if let imagUrlAl = imgUrl as? String {
            Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                print(response)
                if let image = response.result.value {
                    DispatchQueue.main.async{
                        imageSet.image = image
                    }
                }
            })
        }
    }
    */
    
    // POST Services
    static func postService(url: String, parameters: [String:Any], callback: @escaping (JSON?) -> ()) {
        
        if !reachabilityManager.isReachable {
            callback(nil)
            
        } else {
            Alamofire.request(url, method: .post, parameters: parameters,  encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    callback(json)
                case .failure(let error):
                    print(error)
                    callback(nil)
                }
            }
        }
    }
    
    static func postServiceWithAuth(url: String, parameters: [String:Any], callback: @escaping (JSON?) -> ()) {
        
        if !reachabilityManager.isReachable {
            callback(nil)
            
        } else {
          //  let header : HTTPHeaders = ["Authorization": "token"] // Customize it as needed
            let header : HTTPHeaders = ["Authorization": "Bearer wEJa4fD25FJ7W0zZd7STelBmOARPdCuPl9uzzwFFTOI9jmbLbLo4dzrxlp3RTMzIKc-tJeEqeQTtvd9QO00wxCqi1YU73FlVr5LZblfdysFyTgtIMdVHilmjv_Noz5jnXkcaKTNUTcMY20kpaF69ezMzEg8GQY_Ni1HkwdZNww9O6_ueRNZaP08fLInE3LVuFnKChKYGGAlHSDgiRAhcTkBO2AWMPzKYavXcEHZz6d1myYHRsHiXB-BF96ieMxzOM_2LlxXAWG4gvGGj46lAEmEBVGDRksKGmLCQl1JMMH5qnQ8Zth2FoT_Vj1-DQPiHkSJA8tDl-CtaR4_K3U73-KP3UJ7iHDzGt7Pr1nvlMI9LXgkuFcxM2cw4WlqrwgSywxENP6x41JqKVo5UDjiEH7eH5NuBWftAjasp4XeaKsRuNmEY6U2z3hjgUzXHpHtc"] // Customize it as needed

            Alamofire.request(url, method: .post, parameters: parameters,  encoding: JSONEncoding.default, headers: URLs.headerAuth)
                .validate(statusCode: 200..<600)
                .responseJSON { (response) in
                
                print(parameters)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    callback(json)
                case .failure(let error):
                    
                    print(error)
                    if let data = response.data {
                        print("Print Server Error: " + String(data: data, encoding: String.Encoding.utf8)!)
                    }
                    callback(nil)
                }
            }
        }
    }
    
    // PUT Services
    static func putService(url: String, parameters: [String:Any], callback: @escaping (JSON?) -> ()) {
        
        if !reachabilityManager.isReachable {
            callback(nil)
            
        } else {
            Alamofire.request(url, method: .put, parameters: parameters,  encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    callback(json)
                case .failure(let error):
                    print(error)
                    callback(nil)
                }
            }
        }
    }
    
    static func putServiceWithAuth(url: String, parameters: [String:Any], callback: @escaping (JSON?) -> ()) {
        
        if !reachabilityManager.isReachable {
            callback(nil)
            
        } else {
            let header : HTTPHeaders = ["Authorization": "token"] // Customize it as needed
            Alamofire.request(url, method: .put, parameters: parameters,  encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    callback(json)
                case .failure(let error):
                    print(error)
                    callback(nil)
                }
            }
        }
    }
    
    // DELETE Services
    static func deleteService(url: String, parameters: [String:Any], callback: @escaping (JSON?) -> ()) {
        
        if !reachabilityManager.isReachable {
            callback(nil)
            
        } else {
            Alamofire.request(url, method: .delete, parameters: parameters,  encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    callback(json)
                case .failure(let error):
                    print(error)
                    callback(nil)
                }
            }
        }
    }
    
    static func deleteServiceWithAuth(url: String, parameters: [String:Any], callback: @escaping (JSON?) -> ()) {
        
        if !reachabilityManager.isReachable {
            callback(nil)
            
        } else {
            let header : HTTPHeaders = ["Authorization": "token"] // Customize it as needed
            Alamofire.request(url, method: .delete, parameters: parameters,  encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    callback(json)
                case .failure(let error):
                    print(error)
                    callback(nil)
                }
            }
        }
    }
    
}

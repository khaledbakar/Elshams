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
            let header : HTTPHeaders = ["Authorization": "token"] // Customize it as needed
            Alamofire.request(url, headers: header).responseJSON { (response) in
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
            let header : HTTPHeaders = ["Authorization": "token"] // Customize it as needed
            Alamofire.request(url, method: .post, parameters: parameters,  encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
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

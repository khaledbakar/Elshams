//
//  PhoneCall.swift
//  Elshams
//
//  Created by mac on 1/17/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import UIKit
class PhoneCall {
    static func makeCall(PhoneNumber:String){
    guard let url = URL(string: "telprompt://\(PhoneNumber)")
    else {
    return
    }
    UIApplication.shared.open(url)
}
}

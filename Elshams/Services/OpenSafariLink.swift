//
//  OpenSafariLink.swift
//  Elshams
//
//  Created by mac on 1/17/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import UIKit
import SafariServices


class OpenSafariLink {
    static func openLink(WebsiteLink:String) {
     guard let url = URL(string: WebsiteLink)
        else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        //present(safariVC, animated: true, completion: nil) msh radi 3shan present
        
}
    
}

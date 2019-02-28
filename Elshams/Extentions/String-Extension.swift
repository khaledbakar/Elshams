//
//  String-Extension.swift
//  Elshams
//
//  Created by mac on 1/28/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    func fillZeroLeft(_ length: Int) -> String {
        if self.characters.count < length {
            return String.init(repeating: "0", count: length-self.characters.count) + self
        } else {
            return self
        }
    }
}

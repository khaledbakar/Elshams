//
//  String-Extension.swift
//  Elshams
//
//  Created by mac on 1/28/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

extension String {
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}

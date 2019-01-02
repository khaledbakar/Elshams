//
//  UIColor.swift
//  Elshams
//
//  Created by mac on 12/23/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
extension UIColor {
    
    // Setup custom colours we can use throughout the app using hex values
    static let seemGray = UIColor(hex: 0xf8f8f8)
    static let seemDrakGray = UIColor(hex: 0xa0a0a2)
    static let seemLightGreen = UIColor(hex: 0x52d0c4)
    static let seemStone = UIColor(hex: 0xd25156)
    static let seemLightPurple = UIColor(hex: 0x8e88f6)
    static let seemLightOrange = UIColor(hex: 0xfaac5a)
    static let seemDarkBlueBar = UIColor(hex: 0x028ac6)
    static let menuBar = UIColor(hex: 0xED1C23)
    static let statusBar = UIColor(hex: 0xbe1c23)


    
    static let youtubeRed = UIColor(hex: 0xf80000)
    static let transparentBlack = UIColor(hex: 0x000000, a: 0.5)
    static let rgbRed = UIColor(red: 255, green: 0, blue: 0)
    
    // Create a UIColor from RGB
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    // Create a UIColor from a hex value (E.g 0x000000)
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
}

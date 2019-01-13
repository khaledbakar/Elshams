//
//  MdcText.swift
//  Elshams
//
//  Created by mac on 1/13/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import  MaterialComponents.MaterialTextFields

class MdcText {
    static var textFieldControllerFloating = MDCTextInputControllerUnderline()

    static func mdcTextField (textFInput:MDCTextField , Placeholder: String) {
        textFInput.placeholder = Placeholder
        textFInput.isEnabled = true
        textFInput.isUserInteractionEnabled = true
        textFInput.clearButtonMode = .whileEditing
        
        textFieldControllerFloating = MDCTextInputControllerUnderline(textInput: textFInput)
        textFieldControllerFloating.leadingUnderlineLabelTextColor = UIColor.darkGray
        textFieldControllerFloating.trailingUnderlineLabelTextColor = UIColor.green
        textFieldControllerFloating.inlinePlaceholderColor = UIColor.white
       
        textFieldControllerFloating.isFloatingEnabled = true
        
        textFieldControllerFloating.activeColor = UIColor.lightGray
        textFieldControllerFloating.floatingPlaceholderActiveColor = UIColor.white
        textFieldControllerFloating.normalColor = UIColor.white                         
        textFieldControllerFloating.errorColor = UIColor.red
        
    }
}

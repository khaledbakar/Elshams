//
//  MenuCompCell.swift
//  Elshams
//
//  Created by mac on 11/29/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import UIKit

class MenuCompCell: BaseCompMenuCell {
  
    @IBOutlet weak var barName : UILabel?
    override func setupViews() {
        super.setupViews()
        barName?.tintColor = UIColor.init(red: 91.0, green: 14.0, blue: 12.0, alpha: 1.0)
        addConstraint(NSLayoutConstraint(item: barName, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: barName, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }

    }
/*

    override var isHighlighted: Bool {
        didSet {
            DispatchQueue.main.async {

            barName!.tintColor = isHighlighted ? UIColor.white : .init(red: 91.0, green: 14.0, blue: 12.0, alpha: 1.0)
        }
    }
    override var isSelected: Bool {
        didSet {
            barName!.tintColor = isSelected ? UIColor.white : .init(red: 91.0, green: 14.0, blue: 12.0, alpha: 1.0)
        }
    }
 
}
 */

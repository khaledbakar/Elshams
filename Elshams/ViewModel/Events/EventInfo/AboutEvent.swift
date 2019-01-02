//
//  AboutEvent.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class AboutEvent: UIViewController {

    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var screenMap: UIImageView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventDescribtion: UITextView!
    var eventTempName = "Tech Invest"
    override func viewDidLoad() {
        super.viewDidLoad()
        eventName.text = "What is \(eventTempName)"
        eventImage.layer.cornerRadius = eventImage.frame.width / 2
        eventImage.clipsToBounds = true

      
    }
    
}

extension AboutEvent : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "About")
    }
}

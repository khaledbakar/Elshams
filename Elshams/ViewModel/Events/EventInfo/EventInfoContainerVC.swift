//
//  EventInfoContainerVC.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class EventInfoContainerVC: ButtonBarPagerTabStripViewController  {
    var singleItem:EventsData?

    override func viewDidLoad() {
        loadDesign()
        

        super.viewDidLoad()

    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
       let about = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutEvent")
        let agenda = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventAgenda")
        let speakers = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventSpeakers")
        let sponsers = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventSponsers")
        let startup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventStartups")
        
        return [about,agenda,speakers,sponsers,startup]
    }

    func loadDesign()  {
        self.settings.style.selectedBarHeight = 1
        self.settings.style.selectedBarBackgroundColor = UIColor.menuBar
        self.settings.style.buttonBarBackgroundColor = UIColor.menuBar
        self.settings.style.buttonBarItemBackgroundColor = UIColor.menuBar
        self.settings.style.selectedBarBackgroundColor = .white
        self.settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        self.settings.style.selectedBarHeight = 4.0
        self.settings.style.buttonBarMinimumLineSpacing = 0
        self.settings.style.buttonBarItemTitleColor = .white
        self.settings.style.buttonBarItemsShouldFillAvailableWidth = true
        self.settings.style.buttonBarLeftContentInset = 0
        self.settings.style.buttonBarRightContentInset = 0
      // self.bar
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, ProgressPercentage: CGFloat,changeCurrentIndex: Bool, animated: Bool ) -> Void in
            guard changeCurrentIndex == true else {return}
            oldCell?.label.textColor = UIColor.white
            newCell?.label.textColor = UIColor.lightGray
        }
    }

}

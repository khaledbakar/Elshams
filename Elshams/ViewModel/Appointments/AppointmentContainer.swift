//
//  AppointmentContainer.swift
//  Elshams
//
//  Created by mac on 12/6/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import  XLPagerTabStrip

class AppointmentContainer: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        loadDesign()
        

        super.viewDidLoad()

        
    }
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let accepted = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AcceptedAppointment")
        let pending = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PendingAppointment")
        return [accepted,pending]
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
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, ProgressPercentage: CGFloat,changeCurrentIndex: Bool, animated: Bool ) -> Void in
            guard changeCurrentIndex == true else {return}
            oldCell?.label.textColor = UIColor.white
            newCell?.label.textColor = UIColor.lightGray
        }
    }


   

}

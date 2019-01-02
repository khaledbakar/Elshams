//
//  MainAgentContainer.swift
//  Elshams
//
//  Created by mac on 11/29/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MainAgentContainer: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        self.loadDesign()

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let agents = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AllAgents")
        let favourite = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavouriteAgents")
        
        return [agents,favourite]
    }

    func loadDesign()  {
        self.settings.style.selectedBarHeight = 1
        self.settings.style.selectedBarBackgroundColor = UIColor.black
        self.settings.style.buttonBarBackgroundColor = UIColor.black
        self.settings.style.buttonBarItemBackgroundColor = UIColor.black
        self.settings.style.selectedBarBackgroundColor = .white
        self.settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 13)
        self.settings.style.selectedBarHeight = 4.0
        self.settings.style.buttonBarMinimumLineSpacing = 0
        self.settings.style.buttonBarItemTitleColor = .white
        self.settings.style.buttonBarItemsShouldFillAvailableWidth = true
        self.settings.style.buttonBarLeftContentInset = 0
        self.settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, ProgressPercentage: CGFloat,changeCurrentIndex: Bool, animated: Bool ) -> Void in
            guard changeCurrentIndex == true else {return}
            oldCell?.label.textColor = UIColor.white
            newCell?.label.textColor = UIColor.gray
        }
    }

}

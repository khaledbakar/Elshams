//
//  AllAgentsVC.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class AllAgentsVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    var companyAgentList = Array<CompanyItems>()

    override func viewDidLoad() {
        super.viewDidLoad()
        companyAgentList.append(CompanyItems(CompanyName: "EmaarMasr", CompanyAddress: "Cairo,Egypt", CompanyDetail: "the most famous", CompanyImage: "rest"))
        companyAgentList.append(CompanyItems(CompanyName: "EmaarMasr2", CompanyAddress: "Cairo,Egypt2", CompanyDetail: "the most famous2", CompanyImage: "rest2"))

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companyAgentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allagentscell", for: indexPath) as! AllAgentsCell
        cell.setAllagentCell(CompanyAgentList: companyAgentList[indexPath.row])
        return cell
    }

   

}
extension AllAgentsVC : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "AllAgents")
    }
}

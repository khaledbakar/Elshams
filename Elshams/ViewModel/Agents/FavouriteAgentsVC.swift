//
//  FavouriteAgentsVC.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FavouriteAgentsVC: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate {

    var companyFavAgentList = Array<CompanyItems>()
    override func viewDidLoad() {
        super.viewDidLoad()

        companyFavAgentList.append(CompanyItems(CompanyName: "EmaarMasr", CompanyAddress: "Cairo,Egypt", CompanyDetail: "the most famous3", CompanyImage: "rest3"))
        companyFavAgentList.append(CompanyItems(CompanyName: "EmaarMasr", CompanyAddress: "Cairo,Egypt3", CompanyDetail: "the most famous3", CompanyImage: "rest3"))

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companyFavAgentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favagentscell", for: indexPath) as! FavouriteAgentsCell
        cell.setFavouriteAgentCell(CompanyFavAgentList: companyFavAgentList[indexPath.row])
        return cell
    }
    
  

}
extension FavouriteAgentsVC : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "My Favourite")
    }
}

//
//  FavouriteAgentsCell.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class FavouriteAgentsCell: UICollectionViewCell {
    @IBOutlet weak var companyFavAgName: UILabel!    
    @IBOutlet weak var companyFavAgAddress: UILabel!
    @IBOutlet weak var companyFavAgDetail: UITextView!
    @IBOutlet weak var companyFavAgImage: UIImageView!
    
    func setFavouriteAgentCell(CompanyFavAgentList:CompanyItems) {
        companyFavAgName.text = CompanyFavAgentList.companyName
        companyFavAgAddress.text = CompanyFavAgentList.companyAddress
        companyFavAgDetail.text = CompanyFavAgentList.companyDetail
        companyFavAgImage.image = UIImage(named: CompanyFavAgentList.companyName ?? "rest")
        
    }
}
    


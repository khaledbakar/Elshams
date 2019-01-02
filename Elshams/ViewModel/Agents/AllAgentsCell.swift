//
//  AllAgentsCell.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class AllAgentsCell: UICollectionViewCell {
    @IBOutlet weak var companyAgentName: UILabel!
    @IBOutlet weak var companyAgentAddress: UILabel!
    @IBOutlet weak var companyAgentDetail: UITextView!
    @IBOutlet weak var companyAgentmage: UIImageView!
    
    func setAllagentCell(CompanyAgentList:CompanyItems) {
        
        companyAgentName.text = CompanyAgentList.companyName
        companyAgentAddress.text = CompanyAgentList.companyAddress
        companyAgentDetail.text = CompanyAgentList.companyDetail
        companyAgentmage.image = UIImage(named: (CompanyAgentList.companyName)! ?? "rest")
        
    }
}

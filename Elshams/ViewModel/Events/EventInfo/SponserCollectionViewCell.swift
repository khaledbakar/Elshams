//
//  SponserCollectionViewCell.swift
//  Elshams
//
//  Created by mac on 12/20/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class SponserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sponserColImage: UIImageView!
    @IBOutlet weak var sponserRank: UILabel!
    @IBOutlet weak var sponserColName: UILabel!
    
    func setSponserColCell(sponserList:Sponsers) {
        sponserColImage.layer.cornerRadius = sponserColImage.frame.width / 2
        sponserColImage.clipsToBounds = true
        sponserColName.text = sponserList.name
        if sponserList.sponsersponserRank == "Gold"{
            sponserRank.textColor = UIColor.orange
        } else {
            sponserRank.textColor = UIColor.blue
        }
        sponserRank.text = sponserList.sponsersponserRank
        sponserColImage.image = UIImage(named: "\((sponserList.sponserImage)!)")
}
}

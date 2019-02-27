//
//  SponserTimeLineCell.swift
//  Elshams
//
//  Created by mac on 2/27/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SponserTimeLineCell: UICollectionViewCell {
    @IBOutlet weak var sponserLogo: UIImageView!
    
    @IBOutlet weak var sponserName: UILabel!
    
    func setSponserTimeLineCell(sponsersList:Sponsers) {
        sponserLogo.layer.cornerRadius = sponserLogo.frame.width / 2
        sponserLogo.clipsToBounds = true
        
        sponserName.text = sponsersList.sponserName
        if sponsersList.sponserImageUrl != nil ||  !((sponsersList.sponserImageUrl?.isEmpty)!) {
            //  imgUrl(imgUrl: )
            Helper.loadImagesKingFisher(imgUrl: (sponsersList.sponserImageUrl)!, ImgView: sponserLogo)
        }
    }
}

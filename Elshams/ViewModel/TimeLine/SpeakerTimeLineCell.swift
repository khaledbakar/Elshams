//
//  SpeakerTimeLineCell.swift
//  Elshams
//
//  Created by mac on 2/27/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SpeakerTimeLineCell: UICollectionViewCell {
    @IBOutlet weak var speakerLogo: UIImageView!
    
    @IBOutlet weak var speakerName: UILabel!
    
    func setSpeakerTimeLineCell(speakersList:Speakers) {
        speakerLogo.layer.cornerRadius = speakerLogo.frame.width / 2
        speakerLogo.clipsToBounds = true
        
        speakerName.text = speakersList.name
        if speakersList.speakerImageUrl != nil ||  !((speakersList.speakerImageUrl?.isEmpty)!) {
            //  imgUrl(imgUrl: )
            Helper.loadImagesKingFisher(imgUrl: (speakersList.speakerImageUrl)!, ImgView: speakerLogo)
        }
    }
}

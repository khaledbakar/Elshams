//
//  SpeakerCollectionViewCell.swift
//  Elshams
//
//  Created by mac on 12/14/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class SpeakerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var speakerColImage: UIImageView!
    @IBOutlet weak var speakerColJobDescribtion: UILabel!
    @IBOutlet weak var speakerColJobTitle: UILabel!
    @IBOutlet weak var speakerColName: UILabel!
    
    func setSpeakerColCell(speakerList:Speakers) {
        speakerColImage.layer.cornerRadius = speakerColImage.frame.width / 2
        speakerColImage.clipsToBounds = true
        speakerColName.text = speakerList.name
        speakerColJobTitle.text = speakerList.jobTitle
        speakerColJobDescribtion.text = speakerList.jobDescribition
        speakerColImage.image = UIImage(named: "\((speakerList.speakerImage)!)")
    }
    
}

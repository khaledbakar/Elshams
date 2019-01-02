//
//  SpeakersCell.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class SpeakersCell: UITableViewCell {

    @IBOutlet weak var speakerImage: UIImageView!
    @IBOutlet weak var speakerJobDescribtion: UILabel!
    @IBOutlet weak var speakerJobTitle: UILabel!
    @IBOutlet weak var speakerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setSpeakerCell(speakerList:Speakers) {
        speakerImage.layer.cornerRadius = speakerImage.frame.width / 2
        speakerImage.clipsToBounds = true
        speakerName.text = speakerList.name
        speakerJobTitle.text = speakerList.jobTitle
        speakerJobDescribtion.text = speakerList.jobDescribition
        speakerImage.image = UIImage(named: "\((speakerList.speakerImage)!)")
    }

}

//
//  AcceptedCell.swift
//  Elshams
//
//  Created by mac on 12/6/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class AcceptedCell: UITableViewCell {
    @IBOutlet weak var startupImage: UIImageView!
    @IBOutlet weak var startupAddress: UILabel!
    @IBOutlet weak var startupName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
 
    
    func setStartupCell(startupsList:StartUpsData) {
        startupName.text = startupsList.startupName
        startupImage.layer.cornerRadius = startupImage.frame.width / 2
        startupImage.clipsToBounds = true
        if startupsList.startupImageUrl != nil {
            Helper.loadImagesKingFisher(imgUrl: (startupsList.startupImageUrl)!, ImgView: startupImage)
        }
        let email = startupsList.contectInforamtion?["Email"] as? String
        if email == nil || email == "" {
            
        } else {
            startupAddress.text = email
        }
       
    }
    
}

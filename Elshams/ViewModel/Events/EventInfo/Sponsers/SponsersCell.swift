//
//  SponsersCell.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SponsersCell: UITableViewCell {

    @IBOutlet weak var sponserType: UILabel!
    @IBOutlet weak var sponserImage: UIImageView!
    @IBOutlet weak var sponserAddress: UILabel!
    @IBOutlet weak var sponserName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setSponserCell(sponsersList:Sponsers) {
        sponserImage.layer.cornerRadius = sponserImage.frame.width / 2
        sponserImage.clipsToBounds = true
       
        sponserName.text = sponsersList.sponserName
        sponserAddress.text = sponsersList.sponserAddress
        if sponsersList.sponserImageUrl != nil ||  !((sponsersList.sponserImageUrl?.isEmpty)!) {
      //  imgUrl(imgUrl: )
            Helper.loadImagesKingFisher(imgUrl: (sponsersList.sponserImageUrl)!, ImgView: sponserImage)
        }
        let sposnserTypeName = sponsersList.sponsertype!["name"] as? String
        let sposnserTypeColor = sponsersList.sponsertype!["color"] as? String
        if sposnserTypeName != nil && sposnserTypeName != "" {
            sponserType.text = sposnserTypeName
            if sposnserTypeColor == nil || sposnserTypeColor == "" {
                sponserType.textColor  = UIColor.darkText

           // sponserType.textColor  = UIColor(hexString: sposnserTypeColor!)
         //       sponserImage.layer.borderWidth = 1.0
               sponserImage.layer.borderColor = UIColor(hexString: sposnserTypeColor!)?.cgColor
            }
            else if sposnserTypeName == "Main" || sposnserTypeName == "Official" || sposnserTypeName == "Strategic Partner" {
                sponserType.textColor  = UIColor(hex: 0xA60809)
                sponserImage.layer.borderColor = UIColor(hex: 0xA60809).cgColor

                
            }else if sposnserTypeName == "Gold" {
                sponserType.textColor  = UIColor(hex: 0xFFC300)
                sponserImage.layer.borderColor = UIColor(hex: 0xFFC300).cgColor

            }
            else if sposnserTypeName == "Platinum" {
                sponserType.textColor  = UIColor(hex: 0x8E8731)
                sponserImage.layer.borderColor = UIColor(hex: 0x8E8731).cgColor

            }
            else {
                sponserType.textColor  = UIColor(hexString: sposnserTypeColor!)
            }
            sponserType.isHidden = false
        }else {
            sponserType.isHidden = true

        }

       // sponserImage.image = UIImage(named: "\((sponsersList.sponserImage)!)")
    }

}

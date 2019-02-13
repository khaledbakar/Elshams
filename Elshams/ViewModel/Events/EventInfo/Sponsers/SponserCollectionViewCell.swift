//
//  SponserCollectionViewCell.swift
//  Elshams
//
//  Created by mac on 12/20/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SponserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sponserColImage: UIImageView!
    @IBOutlet weak var sponserRank: UILabel!
    @IBOutlet weak var sponserColName: UILabel!
    
    func imgUrl(imgUrl:String)  {
        if let imagUrlAl = imgUrl as? String {
            //let s :Int = 0x0020
            Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                print(response)
                switch response.result {
                case .success(let value):
                if let image = response.result.value {
                    DispatchQueue.main.async{
                        
                        self.sponserColImage.image = image
                    }
                }
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
    func setSponserColCell(sponserList:Sponsers) {
        sponserColImage.layer.cornerRadius = sponserColImage.frame.width / 2
        sponserColImage.clipsToBounds = true
        if  sponserList.sponserName != nil {
            sponserColName.text = sponserList.sponserName

        }
        if !((sponserList.sponsertype?.isEmpty)!) || sponserList.sponsertype != nil {
            let sponserTypeName = sponserList.sponsertype!["name"]
            let sponserTypeColor = sponserList.sponsertype!["color"]
            print(sponserTypeColor)
            if sponserTypeName == nil || "\((sponserTypeName)!)" == "<null>" {
                sponserRank.isHidden = true

            }
            else {
                
                sponserRank.isHidden = false
                let spName = "\((sponserTypeName)!)"

            print(spName)
                sponserRank.text = "\((sponserTypeName)!)"
                let spColor = "\((sponserTypeColor)!)"
                print(spColor)
                if sponserTypeColor == nil || "\((sponserTypeColor)!)" == "<null>" {
                    
                } else {
                    // gold not show
                    sponserRank.text = "\((sponserTypeName)!)"

                    sponserRank.isHidden = false
                    sponserRank.textColor = UIColor(hexString: spColor)

                }

            }
        }
        if sponserList.sponserImageUrl != nil ||  !((sponserList.sponserImageUrl?.isEmpty)!) {
            imgUrl(imgUrl: (sponserList.sponserImageUrl)!)
        }
      /*  if sponserList.sponsersponserRank == "Gold"{
            sponserRank.textColor = UIColor.orange
        } else {
            sponserRank.textColor = UIColor.blue
        }
        */
     //   sponserRank.text = sponserList.sponsersponserRank
       // sponserColImage.image = UIImage(named: "\((sponserList.sponserImage)!)")
        
}
}

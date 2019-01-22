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
            Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                print(response)
                if let image = response.result.value {
                    DispatchQueue.main.async{
                        
                        self.sponserColImage.image = image
                    }
                }
            })
        }
    }
    func setSponserColCell(sponserList:Sponsers) {
        sponserColImage.layer.cornerRadius = sponserColImage.frame.width / 2
        sponserColImage.clipsToBounds = true
        sponserColName.text = sponserList.sponserName
      /*  if sponserList.sponsersponserRank == "Gold"{
            sponserRank.textColor = UIColor.orange
        } else {
            sponserRank.textColor = UIColor.blue
        }
        */
     //   sponserRank.text = sponserList.sponsersponserRank
       // sponserColImage.image = UIImage(named: "\((sponserList.sponserImage)!)")
        imgUrl(imgUrl: (sponserList.sponserImageUrl)!)
}
}

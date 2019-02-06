//
//  SpeakerCollectionViewCell.swift
//  Elshams
//
//  Created by mac on 12/14/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage



class SpeakerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var speakerColImage: UIImageView!
    @IBOutlet weak var speakerColJobDescribtion: UILabel!
    @IBOutlet weak var speakerColJobTitle: UILabel!
    @IBOutlet weak var speakerColName: UILabel!
    
    func imgUrl(imgUrl:String)  {
        
        if let imagUrlAl = imgUrl as? String {
            Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                print(response)
                if let image = response.result.value {
                    DispatchQueue.main.async{
                        
                        self.speakerColImage.image = image
                    }
                }
            })
        }
    }
    
    func setSpeakerColCell(speakerList:Speakers) {
        speakerColImage.layer.cornerRadius = speakerColImage.frame.width / 2
        speakerColImage.clipsToBounds = true
        speakerColName.text = speakerList.name
        speakerColJobTitle.text = speakerList.jobTitle
        speakerColJobDescribtion.text = speakerList.companyName
        imgUrl(imgUrl: (speakerList.speakerImageUrl)!)
      //  speakerColImage.image = UIImage(named: "\((speakerList.speakerImage)!)")
    }
    
}

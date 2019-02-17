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
    
    @IBOutlet weak var linkedInBtn: UIButton!
    @IBOutlet weak var linkedInImgBtn: UIImageView!
    @IBOutlet weak var speakerColJobTitle: UILabel!
    @IBOutlet weak var speakerColName: UILabel!
    
    func imgUrl(imgUrl:String)  {
        if imgUrl == nil || imgUrl.trimmed == "" {
            return
        } else {
        if let imagUrlAl = imgUrl as? String {
            Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                print(response)
                switch response.result {
                case .success(let value):
                if let image = response.result.value {
                    DispatchQueue.main.async{
                        
                        self.speakerColImage.image = image
                    }
                }
                case .failure(let error):
                print(error)
            }
            })
        }
        }
    }
    
    func setSpeakerColCell(speakerList:Speakers) {

        speakerColImage.layer.cornerRadius = speakerColImage.frame.width / 2
        speakerColImage.clipsToBounds = true
        speakerColName.text = speakerList.name
        speakerColJobTitle.text = speakerList.jobTitle
        speakerColJobDescribtion.text = speakerList.companyName
        let linkedIn = speakerList.about
        if linkedIn == "" || linkedIn == nil {
            linkedInImgBtn.isHidden = true
            linkedInBtn.isHidden = true

        } else {
            linkedInImgBtn.isHidden = false
            linkedInBtn.isHidden = false

        }
        
        if speakerList.speakerImageUrl != nil {
            imgUrl(imgUrl: (speakerList.speakerImageUrl)!)

        }
      //  speakerColImage.image = UIImage(named: "\((speakerList.speakerImage)!)")
    }
    
}

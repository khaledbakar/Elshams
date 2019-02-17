//
//  SpeakersCell.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

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
                                
                                self.speakerImage.image = image
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                })
            }
        }
        
    }
    
    func setSpeakerCell(speakerList:Speakers) {
        speakerImage.layer.cornerRadius = speakerImage.frame.width / 2
        speakerImage.clipsToBounds = true
        speakerName.text = speakerList.name
        speakerJobTitle.text = speakerList.jobTitle
        speakerJobDescribtion.text = speakerList.companyName
       
        imgUrl(imgUrl: (speakerList.speakerImageUrl)!)
        
       // speakerImage.image = UIImage(named: "\((speakerList.speakerImage)!)")
    }

}

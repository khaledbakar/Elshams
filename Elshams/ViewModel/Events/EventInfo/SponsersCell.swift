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
    func imgUrl(imgUrl:String)  {
        
        if let imagUrlAl = imgUrl as? String {
            Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                print(response)
                if let image = response.result.value {
                    DispatchQueue.main.async{
                        
                        self.sponserImage.image = image
                    }
                }
            })
        }
    }
    func setSponserCell(sponsersList:Sponsers) {
        sponserImage.layer.cornerRadius = sponserImage.frame.width / 2
        sponserImage.clipsToBounds = true
        sponserName.text = sponsersList.sponserName
        sponserAddress.text = sponsersList.sponserAddress
        imgUrl(imgUrl: (sponsersList.sponserImageUrl)!)
       // sponserImage.image = UIImage(named: "\((sponsersList.sponserImage)!)")
    }

}

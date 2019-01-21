//
//  NetworksCell.swift
//  Elshams
//
//  Created by mac on 12/5/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class NetworksCell: UITableViewCell {

    
    @IBOutlet weak var networkImage: UIImageView!
    @IBOutlet weak var networkJobDescribtion: UILabel!
    @IBOutlet weak var networkJobTitle: UILabel!
    @IBOutlet weak var networkName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func imgUrl(imgUrl:String)  {
        if let imagUrlAl = imgUrl as? String {
            Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                print(response)
                if let image = response.result.value {
                    DispatchQueue.main.async{
                        self.networkImage.image = image
                    }
                }
            })
        }
    }
    func setNetworkCell(networkList:Networks) {
        networkName.text = networkList.name
        networkJobTitle.text = networkList.jobTitle
        networkJobDescribtion.text = networkList.companyName
    //    networkJobDescribtion.text = networkList.jobDescribition
       imgUrl(imgUrl: networkList.imageUrl!)
        networkImage.layer.cornerRadius = networkImage.frame.width / 2
        networkImage.clipsToBounds = true
     //   networkImage.image = UIImage(named: "\((networkList.networkImage)!)")
     // add constraint progmmaticaly 
        //   networkImage.add
        
}
}

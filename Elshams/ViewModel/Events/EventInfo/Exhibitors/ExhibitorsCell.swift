//
//  ExhibitorsCell.swift
//  Elshams
//
//  Created by mac on 2/10/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ExhibitorsCell: UITableViewCell {

    @IBOutlet weak var exhibitorsImage: UIImageView!
    @IBOutlet weak var exhibitorsAddress: UILabel!
    @IBOutlet weak var exhibitorsName: UILabel!
    @IBOutlet weak var sechadualeBtn: UIButton!
    @IBOutlet weak var sechadualeImageBtn: UIImageView!
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
                        self.exhibitorsImage.image = image
                    }
                }
            })
        }
    }
    
    func setExibitorsListCell(exibitorsList:StartUpsData) {
        exhibitorsImage.layer.cornerRadius = exhibitorsImage.frame.width / 2
        exhibitorsImage.clipsToBounds = true
        exhibitorsName.text = exibitorsList.startupName
        imgUrl(imgUrl: (exibitorsList.startupImageUrl)!)
        let email = exibitorsList.contectInforamtion?["Email"]
        

        exhibitorsAddress.text = "\((email)!)"
        if let  apiToken  = Helper.getApiToken() {
            sechadualeBtn.isHidden = false
            sechadualeImageBtn.isHidden = false
            
            
        } else {
            sechadualeBtn.isHidden = true
            sechadualeImageBtn.isHidden = true
            
            
        }
        
        // startupImage.image = UIImage(named: "\((startupsList.startupImage)!)")
        //   print( "\((startupsList.startupImage)!)")
    }
    
}

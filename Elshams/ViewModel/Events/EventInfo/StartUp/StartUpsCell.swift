//
//  StartUpsCell.swift
//  Elshams
//
//  Created by mac on 12/5/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class StartUpsCell: UITableViewCell {

    @IBOutlet weak var startupImage: UIImageView!
    @IBOutlet weak var startupAddress: UILabel!
    @IBOutlet weak var startupName: UILabel!
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
                switch response.result {
                case .success(let value):
                if let image = response.result.value {
                    DispatchQueue.main.async{
                        self.startupImage.image = image
                    }
                }
                case .failure(let error):
                    print(error)
                }
            })
        }
    }

    func setStartupCell(startupsList:StartUpsData) {
        startupImage.layer.cornerRadius = startupImage.frame.width / 2
        startupImage.clipsToBounds = true
        startupName.text = startupsList.startupName
        let email = startupsList.contectInforamtion?["Email"]
        startupAddress.text = "\((email)!)"
        if startupsList.startupImageUrl != nil {
            imgUrl(imgUrl: (startupsList.startupImageUrl)!)
        }
      //  startupAddress.text = ""
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

//
//  AllNewsCell.swift
//  Elshams
//
//  Created by mac on 12/12/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
//import AlamofireImage
//import Alamofire
//import SwiftyJSON

class AllNewsCell: UITableViewCell {
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    func setNewsCell(newsList:NewsData) {
        newsTitle.text = newsList.newsTitle
        newsDate.text = newsList.newsDate
        if newsList.newsImgUrl != nil && newsList.newsImgUrl != "" {
            Helper.loadImagesKingFisher(imgUrl: (newsList.newsImgUrl)!, ImgView: newsImage)

        }
    }

}

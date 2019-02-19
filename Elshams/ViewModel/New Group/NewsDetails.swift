//
//  NewsDetails.swift
//  Elshams
//
//  Created by mac on 12/12/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
//import AlamofireImage
//import Alamofire

class NewsDetails: UIViewController {

    var singleItem : NewsData?
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsDetail: UITextView!
    @IBOutlet weak var newsDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "News"
        newsTitle.text = singleItem?.newsTitle
        newsDate.text = singleItem?.newsDate
        let contentWithoutHtml = singleItem?.newsContent?.htmlToString
        newsDetail.text = contentWithoutHtml
        if singleItem?.newsImgUrl == nil || singleItem?.newsImgUrl  == "" {
       
        }
        else {
            Helper.loadImagesKingFisher(imgUrl: (singleItem?.newsImgUrl)!, ImgView: newsImage )
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    
 

}

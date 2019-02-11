//
//  NewsDetails.swift
//  Elshams
//
//  Created by mac on 12/12/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

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
        newsDetail.text = singleItem?.newsContent
        if singleItem?.newsImgUrl != nil {
        imgUrl(imgUrl: (singleItem?.newsImgUrl)!)
        }// need to nil handler
       // newsImage.image = UIImage(named: "\((singleItem?.newsImgUrl)!)")

    }
    func imgUrl(imgUrl:String)  {
        if let imagUrlAl = imgUrl as? String {
            Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                print(response)
                switch response.result {
                case .success(let value):
                if let image = response.result.value {
                    DispatchQueue.main.async{
                        self.newsImage.image = image
                    }
                }
                case .failure(let error):
                    print(error)
                }
            })
        }
    }

}

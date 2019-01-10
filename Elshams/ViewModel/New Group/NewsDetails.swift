//
//  NewsDetails.swift
//  Elshams
//
//  Created by mac on 12/12/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

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
        newsDetail.text = singleItem?.newsDetail
        newsImage.image = UIImage(named: "\((singleItem?.newsImgUrl)!)")

    }
    

}

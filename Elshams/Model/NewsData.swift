//
//  NewsData.swift
//  Elshams
//
//  Created by mac on 12/12/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
class NewsData {
    var newsID : String?
    var newsTitle : String?
    var newsImgUrl : String?
    var newsContent : String?
    var newsDate : String?

    init(NewsTitle:String,NewsImageUrl:String,NewsContent:String,NewsDate:String,NewsID:String) {
        self.newsTitle = NewsTitle
        self.newsImgUrl = NewsImageUrl
        self.newsContent = NewsContent
        self.newsDate = NewsDate
        self.newsID = NewsID
    }
}

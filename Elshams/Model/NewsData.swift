//
//  NewsData.swift
//  Elshams
//
//  Created by mac on 12/12/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
class NewsData {
    var newsTitle : String?
    var newsImgUrl : String?
    var newsDetail : String?
    var newsDate : String?

    init(NewsTitle:String,NewsImageUrl:String,NewsDetail:String,NewsDate:String) {
        self.newsTitle = NewsTitle
        self.newsImgUrl = NewsImageUrl
        self.newsDetail = NewsDetail
        self.newsDate = NewsDate
    }
}

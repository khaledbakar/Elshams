//
//  CollectioViewItems.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
class CollectionViewItems {
    var name:String?
    var address:String?
    var detail:String?
    var imageUrl:String?
    init(Name:String,Address:String,Detail:String,ImageUrl:String) {
        self.name = Name
        self.address = Address
        self.detail = Detail
        self.imageUrl = ImageUrl
        
    }
}

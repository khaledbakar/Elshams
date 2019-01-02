//
//  EventsCell.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class EventsCell: UICollectionViewCell {
    @IBOutlet weak var EventName: UILabel!
    @IBOutlet weak var EventDetails: UITextView!
    @IBOutlet weak var EventAddress: UILabel!    
    @IBOutlet weak var EventImage: UIImageView!
    
    func setEventsCell(EventItemsList:CollectionViewItems)  {
        EventName.text = EventItemsList.name
        EventAddress.text = EventItemsList.address
        EventDetails.text = EventItemsList.detail
        EventImage.image = UIImage(named: "\((EventItemsList.imageUrl)!)")
        print("\((EventItemsList.imageUrl)!)")
    }
    
    
}

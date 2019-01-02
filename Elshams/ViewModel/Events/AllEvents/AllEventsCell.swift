//
//  AllEventsCell.swift
//  Elshams
//
//  Created by mac on 12/24/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class AllEventsCell: UITableViewCell {
    @IBOutlet weak var EventName: UILabel!
    @IBOutlet weak var EventImg: UIImageView!
    @IBOutlet weak var EventAddress: UILabel!
    @IBOutlet weak var EventDetails: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func setEventsCell(EventsItemsList:EventsData)  {
        EventName.text = EventsItemsList.eventsName
        EventAddress.text = EventsItemsList.eventsAddress
        EventDetails.text = EventsItemsList.eventsDetail
        EventImg.layer.cornerRadius = EventImg.frame.width / 2
        EventImg.clipsToBounds = true
        EventImg.image = UIImage(named: "\((EventsItemsList.eventsImage)!)")
    }
}

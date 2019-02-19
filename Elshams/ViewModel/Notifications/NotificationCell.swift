//
//  NotificationCell.swift
//  Elshams
//
//  Created by mac on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class NotificationCell: UITableViewCell {

    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setNotificationCell(NotificationList:Notifications)  {
        notificationTitle.text = NotificationList.notification_Title
        notificationDetail.text = NotificationList.notification_Body
        if NotificationList.notification_ImageUrl != nil {
         Helper.loadImagesKingFisher(imgUrl: (NotificationList.notification_ImageUrl)!, ImgView: notificationImage)
        }
        notificationImage.layer.cornerRadius = notificationImage.frame.width / 2
        notificationImage.clipsToBounds = true
    }

}

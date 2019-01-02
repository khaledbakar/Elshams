//
//  PendingCell.swift
//  Elshams
//
//  Created by mac on 12/6/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class PendingCell: UITableViewCell {
    @IBOutlet weak var startupImage: UIImageView!
    @IBOutlet weak var startupAddress: UILabel!
    @IBOutlet weak var startupName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func btnRescudule(_ sender: Any) {
    }
    
    @IBAction func btnCancel(_ sender: Any) {
    }
    func setStartupCell(startupsList:StartUpsData) {
        startupName.text = startupsList.name
        startupAddress.text = startupsList.startupAddress
        startupImage.image = UIImage(named: "\((startupsList.startupImage)!)")
    }
    
}

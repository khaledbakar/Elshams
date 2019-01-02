//
//  SponsersCell.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class SponsersCell: UITableViewCell {

    @IBOutlet weak var sponserImage: UIImageView!
    @IBOutlet weak var sponserAddress: UILabel!
    @IBOutlet weak var sponserName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func setSponserCell(sponsersList:Sponsers) {
        sponserImage.layer.cornerRadius = sponserImage.frame.width / 2
        sponserImage.clipsToBounds = true
        sponserName.text = sponsersList.name
        sponserAddress.text = sponsersList.sponserAddress
        sponserImage.image = UIImage(named: "\((sponsersList.sponserImage)!)")
    }

}

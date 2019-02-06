//
//  ViewConTableViewCell.swift
//  Elshams
//
//  Created by mac on 1/1/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ViewConTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTest: UILabel!
    @IBOutlet weak var constraintBtn: NSLayoutConstraint!
    
    @IBOutlet weak var viewContainer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func btnTest(_ sender: Any) {
        constraintBtn.constant = constraintBtn.constant + 2
        viewContainer.backgroundColor = UIColor.darkGray
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

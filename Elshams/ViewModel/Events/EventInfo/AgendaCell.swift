//
//  AgendaCell.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class AgendaCell: UITableViewCell {
    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var timeIcon: UIImageView!
    @IBOutlet weak var programAgendaName: UILabel!
    @IBOutlet weak var programAgendaTime: UILabel!
    @IBOutlet weak var programAgendaLocation: UILabel!
    @IBOutlet weak var speakerOneImage: UIImageView!
    @IBOutlet weak var speakerTwoImage: UIImageView!
    @IBOutlet weak var cellColor: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setAgendaCell(AgendaProgram:ProgramAgendaItems,IndexPath:Int)  {
        timeIcon.layer.cornerRadius = timeIcon.frame.width / 2
        timeIcon.clipsToBounds = true
        locationIcon.layer.cornerRadius = locationIcon.frame.width / 2
        locationIcon.clipsToBounds = true
        speakerOneImage.layer.cornerRadius = locationIcon.frame.width / 2
        speakerOneImage.clipsToBounds = true
        speakerTwoImage.layer.cornerRadius = locationIcon.frame.width / 2
        speakerTwoImage.clipsToBounds = true
        
        timeIcon.image = UIImage(named: "time-fav")
        locationIcon.image = UIImage(named: "location_fav")
        
        programAgendaName.text = AgendaProgram.name
        programAgendaTime.text = "\((AgendaProgram.startTime)!) - \((AgendaProgram.endTime)!)"
        programAgendaLocation.text = AgendaProgram.progLocation
        speakerOneImage.image = UIImage(named: "\((AgendaProgram.speakerOneImage)!)")
        speakerTwoImage.image = UIImage(named: "\((AgendaProgram.speakerTwoImage)!)")
        switch IndexPath % 3 {
        case 0:
            cellColor.backgroundColor = UIColor.orange
        case 1:
            cellColor.backgroundColor = UIColor.red
        case 2:
            cellColor.backgroundColor = UIColor.yellow
            
        default:
            cellColor.backgroundColor = UIColor.yellow
            
        }

    }

}

//
//  MyFavouritesCell.swift
//  Elshams
//
//  Created by mac on 12/5/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire
//import AlamofireImage

class MyFavouritesCell: UITableViewCell {
    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var timeIcon: UIImageView!
    
    @IBOutlet weak var favourIcon: UIImageView!
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
        
        //  timeIcon.image = UIImage(named: "time-fav")
        //  locationIcon.image = UIImage(named: "location_fav")
        
        
        
        programAgendaName.text = AgendaProgram.seseionTitle
        programAgendaTime.text = "\((AgendaProgram.sessionTime)!)"
        programAgendaLocation.text = AgendaProgram.progLocation
        //  speakerOneImage.image = UIImage(named: "\((AgendaProgram.speakerOneImage)!)")
        //  speakerTwoImage.image = UIImage(named: "\((AgendaProgram.speakerTwoImage)!)")
        if AgendaProgram.favouriteSession == true {
            favourIcon.image = UIImage(named: "favour")
        }else {
            favourIcon.image = UIImage(named: "favour-unlike")
        }
        if AgendaProgram.rondomColor != nil {
            let randomColor = AgendaProgram.rondomColor
            let colorItem = UIColor(hexString: randomColor!)
            cellColor.backgroundColor = colorItem
        }
        let speaker = AgendaProgram.speakersIdImg
        if !(speaker?.isEmpty)! {
            if speaker != nil {
                let sp1 = speaker![0].speakerImageUrl
                if sp1 == nil {
                    speakerTwoImage.isHidden = true
                }else {
                    speakerTwoImage.isHidden = false
                    Helper.loadImagesKingFisher(imgUrl: sp1!, ImgView: speakerTwoImage)
                }
                
                if (speaker?.count)! > 1 {
                    let sp2 = speaker![1].speakerImageUrl
                    if sp2 == nil {
                        speakerOneImage.isHidden = true
                    }else {
                        speakerOneImage.isHidden = false
                        Helper.loadImagesKingFisher(imgUrl: sp2!, ImgView: speakerOneImage)
                    }
                }
                
            }
            else {
                speakerOneImage.isHidden = true
                speakerTwoImage.isHidden = true
            }
        }
        
    }

}

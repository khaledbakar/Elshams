//
//  AgendaCell.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire
//import AlamofireImage

class AgendaCell: UITableViewCell {
    @IBOutlet weak var favourIcon: UIImageView!
    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var timeIcon: UIImageView!
    @IBOutlet weak var programAgendaName: UILabel!
    @IBOutlet weak var programAgendaTime: UILabel!
    @IBOutlet weak var programAgendaLocation: UILabel!
    @IBOutlet weak var speakerOneImage: UIImageView!
    @IBOutlet weak var speakerTwoImage: UIImageView!
    @IBOutlet weak var cellColor: UIView!
  //  var speakerImgUrl :String?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    /*
    func imgUrl(imgUrl:String,imageSpeakerView:UIImageView)  {
        
        if let imagUrlAl = imgUrl as? String {
            Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                print(response)
                switch response.result {
                case .success(let value):
                if let image = response.result.value {
                    DispatchQueue.main.async{
                        print(imagUrlAl)
                        imageSpeakerView.isHidden = false
                        imageSpeakerView.image = image
                    }
                }
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
    */
    
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
        //UIColor(hexString: randomColor!)
      /*  let randomColorArray =  randomColor?.split(separator: "#")
        var randomColorStr:String = "\(randomColorArray![0])"
        randomColorStr = "0x" + randomColorStr
        print(randomColorStr)
        //randomColorArray = "0x" + randomColorArray
       let randomIntColor:Int = Int(randomColorStr)!
       // cellColor.backgroundColor = UIColor(hex: randomIntColor)
        cellColor.backgroundColor = UIColor(hex: randomIntColor)
         */
    //    let speaker1 = AgendaProgram.speakersSession![0]["imageUrl"]
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
        } else {
            speakerOneImage.isHidden = true
            speakerTwoImage.isHidden = true
        }
        }
        
     /*  switch IndexPath % 3 {
        case 0:
            cellColor.backgroundColor = UIColor.orange
        case 1:
            cellColor.backgroundColor = UIColor.red
        case 2:
            cellColor.backgroundColor = UIColor.yellow
            
        default:
            cellColor.backgroundColor = UIColor.yellow
            
        } */
    }

}

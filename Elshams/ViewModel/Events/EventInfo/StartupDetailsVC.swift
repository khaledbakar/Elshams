//
//  StartupDetailsVC.swift
//  Elshams
//
//  Created by mac on 12/5/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class StartupDetailsVC: UIViewController {
    var singleItem : StartUpsData?
    
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var rescadualeView: UIView!
    
    @IBOutlet weak var sureMessageTxt: UILabel!
    
    var appointmentBooking = ["saturday 9AM","saturday 10AM","saturday 11AM"]
    @IBOutlet weak var startUpLogo: UIImageView!
    
    @IBOutlet weak var popUpContainerView: UIView!
    @IBOutlet weak var startUpName: UILabel!
    @IBOutlet weak var startUpMail: UILabel!
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var aboutStartUp: UITextView!
    @IBOutlet weak var startUpLinkedIn: UILabel!
    @IBOutlet weak var startUpPhone: UILabel!
    
    @IBOutlet weak var informationTopConstraint: NSLayoutConstraint!
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var frameBtn = CGRect(x: 0, y: 0, width: 0, height: 0)
    
  /*  var frameRescadule = CGRect(x: 8.0, y: 215.0, width: 358.0, height: 91.0)
    
    var frameInformationDefalut = CGRect(x: 8.0, y: 215.0, width: 359.0, height: 164.0)
    var frameInformationRescaduale = CGRect(x: 8.0, y: 318.0, width: 359.0, height: 164.0)
  //  var frameInformationRescaduale = CGRect(x: 8.0, y: 207.0, width: 359.0, height: 164.0)
    
    var frameAbout = CGRect(x: 8.0, y: 391, width: 358.0, height: 200.0)
    var frameAboutRescaduale = CGRect(x: 8.0, y: 494, width: 359.0, height: 100.0)
  //  var frameAboutRescaduale = CGRect(x: 8.0, y: 383, width: 359.0, height: 100.0)

    var frameTxtAbout = CGRect(x: 60.0, y: 34, width: 281, height: 120)
    var frameTxtAboutRescaduale = CGRect(x: 60.0, y: 34, width: 281, height: 55) */

    @IBOutlet weak var profieView: UIView!
    
    var appointmentSelect:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        popUpContainerView.isHidden = true
        rescadualeView.isHidden = true
      //  informationTopConstraint.constant = profieView.bottomAnchor.con - 46
       // rescadualeView.frame = frameRescadule
       // defaultFrame()
        
        informationTopConstraint.constant = -46
       
        startUpLogo.layer.cornerRadius = startUpLogo.frame.width / 2
        startUpLogo.clipsToBounds = true
        startUpLogo.image = UIImage(named: (singleItem?.startupImage)!)
      
      
       
        startUpName.text = singleItem?.name
        startUpMail.text = singleItem?.startUpMail
        startUpPhone.text = singleItem?.startUpPhone
        startUpLinkedIn.text = singleItem?.startUpLinkedIn
        aboutStartUp.text = singleItem?.startUpAbout
        btnRightBar()
        // self.navigationController.col
        // startUpLinkedIn.constraints.

      /*  rescadualeView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: rescadualeView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        let heightConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint]) */
        
        //PopUp View
        for index in 0..<appointmentBooking.count {
            frame.origin.x = 55
            frame.origin.y = (45 * CGFloat(index)) + 75
            frame.size = CGSize(width: 200 , height: 20.0)
            
            let lblApointmet = UILabel(frame: frame)
            lblApointmet.text = appointmentBooking[index]
            frameBtn.origin.x = 15
            frameBtn.origin.y = (45 * CGFloat(index)) + 75
            frameBtn.size = CGSize(width: 40 , height: 20.0)
            
            var btnCheck = UIButton(frame: frameBtn)
            btnCheck.setTitle("\(index)", for: .normal)
            btnCheck.isSelected = false
            btnCheck.addTarget(self, action: #selector(butClic(_:)), for: .touchUpInside)
            btnCheck.setImage(UIImage(named: "unCheck"), for: UIControlState.normal)
            btnCheck.setImage(UIImage(named: "check-1"), for: UIControlState.selected)
            btnCheck.tag = index + 1
            
            popUpView.addSubview(lblApointmet)
            popUpView.addSubview(btnCheck)
        }
    }
    
    func defaultFrame() {
      /*  informationView.frame = frameInformationDefalut
        aboutView.frame = frameAbout
        aboutStartUp.frame = frameTxtAbout */
    }
    
    func afterRescadualeFrame() {
     /*   informationView.frame = frameInformationRescaduale
        aboutView.frame = frameAboutRescaduale
        aboutStartUp.frame = frameTxtAboutRescaduale */
    }
    @IBAction func cancelAppointment(_ sender: Any) {
       // defaultFrame()
       // afterRescadualeFrame()
        rescadualeView.isHidden = true
        informationTopConstraint.constant = -46
        btnRightBar()
    }
    
    @IBAction func rescadualeAppointment(_ sender: Any) {
        popUpContainerView.isHidden = false
        btnRightBar()
    }
    
    @objc func butClic (_ sender: UIButton){
        for ind in 2..<popUpView.subviews.count {
            if ind % 2 == 1 {
                print(ind)
                print(popUpView.subviews[ind])
                (popUpView.subviews[ind] as! UIButton).isSelected = false
            } else {
                continue
            }
        }
        sender.isSelected = true
        let  buTitle = "\((sender.currentTitle)!)"
        let buTitleInt = sender.tag - 1
        appointmentSelect = appointmentBooking[buTitleInt]     
    }
    
    func btnRightBar()  {
        let btnAppointment = UIButton(type: UIButton.ButtonType.system)
        btnAppointment.setImage(UIImage(named: "appointment"), for: UIControl.State())
        btnAppointment.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnAppointment.addTarget(self, action: #selector(popUpTool), for: UIControl.Event.touchUpInside)
        btnAppointment.tintColor = UIColor.white
        let customBarItem = UIBarButtonItem(customView: btnAppointment)
        self.navigationItem.rightBarButtonItem = customBarItem;
    }
    
    @objc func popUpTool() {
        popUpContainerView.isHidden = false
        btnRightBar()
    }
    
    
    @IBAction func savePopUpData(_ sender: Any) {
        popUpContainerView.isHidden = true
        rescadualeView.isHidden = false
        informationTopConstraint.constant = 65
      //  afterRescadualeFrame()
        let btnSearch = UIButton(type: UIButton.ButtonType.system)
        let customBarItem = UIBarButtonItem(customView: btnSearch)
        self.navigationItem.rightBarButtonItem = customBarItem
        sureMessageTxt.text = "You have an appointment on \((appointmentSelect)!)!"

    }
    
    @IBAction func buDismissPopUp(_ sender: Any) {
        popUpContainerView.isHidden = true

    }
    

}

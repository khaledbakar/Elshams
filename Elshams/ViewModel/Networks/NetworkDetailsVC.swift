//
//  NetworkDetailsVC.swift
//  Elshams
//
//  Created by mac on 12/5/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class NetworkDetailsVC: UIViewController {
    
    @IBOutlet weak var viewAbout: UIView!
    @IBOutlet weak var viewProfile: UIView!
    
    var singleItem:Networks?
    
    @IBOutlet weak var profileJobTitle: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileEMail: UILabel!
    @IBOutlet weak var profilePhone: UILabel!
    @IBOutlet weak var profileLinkedIn: UILabel!
    @IBOutlet weak var profileAbout: UITextView!
    
    var frameAbout = CGRect(x: 8.0, y: 385, width: 358.0, height: 206.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        profileName.text = (singleItem?.name)!
        profileJobTitle.text = (singleItem?.jobTitle)!
        profileAbout.text = (singleItem?.about)!
        profileEMail.text = (singleItem?.mail)!
        profilePhone.text = (singleItem?.phone)!
        profileLinkedIn.text = (singleItem?.linkedInLink)!
        
        print((singleItem?.jobTitle)!)
        profileImg.layer.cornerRadius = profileImg.frame.width / 2
        profileImg.clipsToBounds = true
        profileImg.image = UIImage(named: "\((singleItem?.networkImage)!)")
        viewAbout.frame = frameAbout
        
       // self.navigationController?.navigationBar.tintColor = UIColor.black
       // self.navigationController?.navigationBar.barStyle = .black
      /*  let navStyles = UINavigationBar.appearance()
        // This will set the color of the text for the back buttons.
        navStyles.tintColor = .black
        // This will set the background color for navBar
        navStyles.barTintColor = .black */
        //self.navigationItem.setHidesBackButton(true, animated: true)
        //self.navigationItem.backBarButtonItem.
    }
    
    /*
    @IBAction func ba(_ sender: Any) {
       // removeFromParentViewController()
        dismiss(animated: true, completion: nil)
    }
    */
  /*  func k() {
        //self.navigationItem.backBarButtonItem.
        removeFromParentViewController()
    } */

}

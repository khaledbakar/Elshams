//
//  SigninVC.swift
//  Elshams
//
//  Created by mac on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class SigninVC: UIViewController {
    @IBOutlet weak var userNameInputlTxt: UITextField!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userNameError: UILabel!
    
    @IBOutlet weak var userProfileImg: UIImageView!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var passwordInputTxt: UITextField!
    @IBOutlet weak var passwordError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameInputlTxt.textColor = UIColor.white
        passwordInputTxt.textColor = UIColor.white
        userProfileImg.layer.cornerRadius = userProfileImg.frame.width / 2
        userProfileImg.clipsToBounds = true
        userNameError.isHidden = true
        passwordError.isHidden = true
    

    }
    @IBAction func skipLogin(_ sender: Any) {
        performSegue(withIdentifier: "skipnav", sender: nil)
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
    }
    
    @IBAction func logIn(_ sender: Any) {
    }
    
}

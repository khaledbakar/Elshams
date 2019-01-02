//
//  RegisterationVC.swift
//  Elshams
//
//  Created by mac on 12/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class RegisterationVC: UIViewController {
    @IBOutlet weak var emaiInputlTxt: UITextField!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailError: UILabel!
    
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var passwordInputTxt: UITextField!
    @IBOutlet weak var passwordError: UILabel!
    
    @IBOutlet weak var jobTitleInput: UITextField!
    @IBOutlet weak var jobTitleError: UILabel!
    @IBOutlet weak var jobTitleLbl: UILabel!
    
    @IBOutlet weak var phoneInputTxt: UITextField!
    @IBOutlet weak var phoneError: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    
    @IBOutlet weak var othersError: UILabel!
    @IBOutlet weak var othersLbl: UILabel!
    @IBOutlet weak var othersInputTxt: UITextField!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.clipsToBounds = true
        emailError.isHidden = true
        passwordError.isHidden = true
        phoneError.isHidden = true
        othersError.isHidden = true
        jobTitleError.isHidden = true

    }
    

    @IBAction func register(_ sender: Any) {
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
}

//
//  RegisterVC.swift
//  EntertainerAgency
//
//  Created by Andrei Giuglea on 01/01/2020.
//  Copyright © 2020 Andrei Giuglea. All rights reserved.
//

import Foundation
import UIKit



class RegisterVC: UIViewController {
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordConfirmTF: UITextField!
    
    
    @IBOutlet weak var employeeL: UILabel!
    @IBOutlet weak var employerL: UILabel!
    
    @IBOutlet weak var passwordCheckL: UILabel!
    
    
    @IBOutlet weak var registerButtonL: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeL.isHidden = true
        passwordCheckL.isHidden = true
        registerButtonL.layer.cornerRadius = 25
    }
    
    
    @IBAction func selectUserType(_ sender: Any) {
        if employeeL.isHidden == true{
                   employeeL.isHidden = false
                   employerL.isHidden = true
               }else{
                   employeeL.isHidden =  true
                   employerL.isHidden = false
               }
    }
    
    
    @IBAction func checkPasswordConfirm(_ sender: Any) {
        
        if passwordTF.text != passwordConfirmTF.text{
            passwordCheckL.isHidden = false
        }
        
    }
    
    @IBAction func registerUser(_ sender: Any) {
        if passwordTF.text != passwordConfirmTF.text{
            ///Alert
        }else{
            ///Register
            performSegue(withIdentifier: "NewUserInfo", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewUserInfo"{
            let vc = segue.destination as! NewUserInfoVC
            vc.email = emailTF.text!
            vc.password = passwordTF.text!
            if employeeL.isHidden == false{
                vc.userType = "employee"
            }else{
                vc.userType = "employer"
            }
            
        }
    }
    
    
}

//
//  NewUserInfoVC.swift
//  EntertainerAgency
//
//  Created by Andrei Giuglea on 04/01/2020.
//  Copyright © 2020 Andrei Giuglea. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class NewUserInfoVC: UIViewController {
    
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var zipcodeTF: UITextField!
    @IBOutlet weak var streetAdressTF: UITextField!
    
    var gender = "M"
    var userType = String()
    var email = String()
    var password = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userType  + " " + email + " " + password)
    }
    
    
    @IBAction func confirmRegistration(_ sender: Any) {
        
        if nameTF.text! == "" || surnameTF.text! == "" || phoneNumberTF.text! == "" || countryTF.text! == "" || stateTF.text! == "" || cityTF.text! == "" || zipcodeTF.text! == "" || streetAdressTF.text! == ""{
            ///alert
            let alert = UIAlertController(title: "Attention!", message: "Please Complete All the Text Fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            ///register
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                 if (error  != nil ){
                        print(error!)
                        //AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
 
                            
                        
                }else{
                    print("User created succesful!")
                    var database = Database()
                    database.openDatabase()
                    let locationID =  database.insertLocation(country: self.countryTF.text!, city: self.cityTF.text!, state: self.stateTF.text!, streetAdress: self.streetAdressTF.text!, zipCode: Int(self.zipcodeTF.text!) ?? 9000)
                    var employeeID: Int
                    if self.userType == "employee"{
                        employeeID = database.insertEmployee(employeeName: self.nameTF.text!, employeeSurname: self.surnameTF.text!, gender: self.gender, rating: 3.5, phoneNumber: Int(self.phoneNumberTF.text!) ?? 0, locationID: locationID)
                    }
                    
                    ///get employeeID insert into firebase with usertype
                    
                    let alert = UIAlertController(title: "Succes!", message: "", preferredStyle: UIAlertController.Style.alert)
                    //alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler:nil))
                    let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (UIAlertAction) in
                        self.dismiss(animated: true, completion: nil)
                    }
                    alert.addAction(alertAction)
                    self.present(alert, animated: true,completion: nil)
                   
                }
            }
            
        }
        
    }
    
    
}

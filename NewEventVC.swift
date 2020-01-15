//
//  NewEventVC.swift
//  EntertainerAgency
//
//  Created by Andrei Giuglea on 26/12/2019.
//  Copyright © 2019 Andrei Giuglea. All rights reserved.
//

import Foundation
import UIKit


class NewEventVC: UIViewController {
    
    
    var startDate = Date()
    var duration = 0
    
    var durationPickerData = [String]()
    
    @IBOutlet weak var eventNameTF: UITextField!
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var durationPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startDatePicker.minimumDate = Date()
    }
    
    
    
    @IBAction func pickStartDate(_ sender: Any) {
        startDate = startDatePicker.date
        print(startDate)
        
    }
    
    @IBAction func introduceLocation(_ sender: Any) {
        performSegue(withIdentifier: "EnterLocation", sender: self)
    }
    
}

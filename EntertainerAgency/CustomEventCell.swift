//
//  CustomEventCell.swift
//  EntertainerAgency
//
//  Created by Andrei Giuglea on 16/01/2020.
//  Copyright © 2020 Andrei Giuglea. All rights reserved.
//

import Foundation
import UIKit

class CustomEventCell: UITableViewCell {
    
    
    
    @IBOutlet weak var eventImage: UIImageView!
   
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    
    
    @IBOutlet weak var employeeLabel: UILabel!
    @IBOutlet weak var employee1Label: UILabel!
    @IBOutlet weak var employee2Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

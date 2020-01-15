//
//  EventsVC.swift
//  EntertainerAgency
//
//  Created by Andrei Giuglea on 26/12/2019.
//  Copyright © 2019 Andrei Giuglea. All rights reserved.
//

import Foundation
import UIKit

class EventsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let database = Database()
    let userType = ""
    var eventInfoEmployee = [EventInfoObjectForEmployee]()
    var eventInfoEmployer = [EventInfoObjectForEmployer]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if(userType == "employee"){
            
            return eventInfoEmployee.count
            
        }else{
            return eventInfoEmployer.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
           let cell = tableView.dequeueReusableCell(withIdentifier: "customEventCell", for: indexPath) as! CustomEventCell
        
        if(userType == "employee"){
                  
            cell.employee1Label.text! = eventInfoEmployee[indexPath.row].employee[0]
            if eventInfoEmployee[indexPath.row].employee[1] != nil{
                cell.employee2Label.text! = eventInfoEmployee[indexPath.row].employee[1]
            }else{
                cell.employee2Label.isHidden = true
            }
            
            cell.employeeLabel.text! = eventInfoEmployee[indexPath.row].eventName
            cell.sumLabel.text! = String(eventInfoEmployee[indexPath.row].cost)
                  
              }else{
            cell.employee1Label.text! = eventInfoEmployer[indexPath.row].employer
                 
            cell.employee2Label.isHidden = true
                 
                 
            cell.employeeLabel.text! = eventInfoEmployer[indexPath.row].eventName
            cell.sumLabel.text! = String(eventInfoEmployer[indexPath.row].cost)
              }
        
        cell
        
        return cell
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        database.openDatabase()
        
        if(userType == "employee"){
            
            eventInfoEmployee = database.getEventsInfoForEmployee()
            
        }else{
            eventInfoEmployer = database.getEventsInfoForEmployer()
        }
    }
}

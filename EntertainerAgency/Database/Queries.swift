//
//  Queries.swift
//  EntertainerAgency
//
//  Created by Andrei Giuglea on 05/01/2020.
//  Copyright © 2020 Andrei Giuglea. All rights reserved.
//

import Foundation
import SQLite3


extension Database{
   
    
    func getTopRatedUsers()->[String:Double]{
        var topRatedUsers = [String:Double]()
        
        
        
        return topRatedUsers
    }
    
    
    func getEventsInfoForEmployee()->[EventInfoObjectForEmployee]{
        
        var eventsInfo = [EventInfoObjectForEmployee]()
        var contor = 0
        var queryStatement: OpaquePointer? = nil
        let queryStatementString = "SELECT EmployeeName, EventName, Cost FROM (Events INNER JOIN Employee ON Employee.ID IN (SELECT EmployeeID FROM Link WHERE(Events.ID = Link.EventID) )INNER JOIN Bill ON Bill.ID = (Select BillID FROM Link WHERE Events.ID = Link.EventID) );"
          
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {

              while (sqlite3_step(queryStatement) == SQLITE_ROW) {
              
                  let employeeCString = sqlite3_column_text(queryStatement, 0)
                  let employeeName = String(cString: employeeCString!)
                  let eventCString = sqlite3_column_text(queryStatement, 1)
                  let eventName = String(cString: eventCString!)
                  let cost = Int(sqlite3_column_int(queryStatement, 2))
                ///if
                if contor > 0{
                    if eventsInfo[contor-1].eventName == eventName {
                        eventsInfo[contor-1].addAnotherEmployee(employee: employeeName)
                    }else{
                        let singleEventInfo = EventInfoObjectForEmployee(eventName: eventName, employee: employeeName, cost: cost)
                        eventsInfo.append(singleEventInfo)
                        contor = contor + 1
                    }
                }
                else{
                   let singleEventInfo = EventInfoObjectForEmployee(eventName: eventName, employee: employeeName, cost: cost)
                   eventsInfo.append(singleEventInfo)
                   contor = contor + 1
                }
                
                
                
                  print(employeeName + " " + eventName + " " + "\(cost)")
              }

          } else {
              print("SELECT statement could not be prepared")
          }
          sqlite3_finalize(queryStatement)
        
        
        
        return eventsInfo
    }
    
    func getEventsInfoForEmployer()->[EventInfoObjectForEmployer]{
        
        var eventsInfo = [EventInfoObjectForEmployer]()
        
        var queryStatement: OpaquePointer? = nil
        let queryStatementString = "SELECT EmployerName, EventName, Cost FROM (Events INNER JOIN Employer ON Employer.ID IN (SELECT EmployerID FROM Link WHERE(Events.ID = Link.EventID) )INNER JOIN Bill ON Bill.ID = (Select BillID FROM Link WHERE Events.ID = Link.EventID) );"
          
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {

              while (sqlite3_step(queryStatement) == SQLITE_ROW) {
              
                  let employerCString = sqlite3_column_text(queryStatement, 0)
                  let employerName = String(cString: employerCString!)
                  let eventCString = sqlite3_column_text(queryStatement, 1)
                  let eventName = String(cString: eventCString!)
                  let cost = Int(sqlite3_column_int(queryStatement, 2))
                
                 let singleEventInfo = EventInfoObjectForEmployer(eventName: eventName, employer: employerName, cost: cost)
                 eventsInfo.append(singleEventInfo)
                  print(employerName + " " + eventName + " " + "\(cost)")
              }

          } else {
              print("SELECT statement could not be prepared")
          }
          sqlite3_finalize(queryStatement)
        
        
        
        return eventsInfo
    }
    
    
    
    func selectEmployeesForEvent(eventID : Int)->[String:Int]{
        ///complex
        var queryStatement: OpaquePointer? = nil
        //(Id, EventName,Date,Duration,LocationID) 
        let queryStatementString = "SELECT Id, EmployeeName   FROM Employee WHERE  Employee.Id IN (SELECT EmployeeID FROM Link WHERE EventID = '\(eventID)' );"
        var employees = [String:Int]()
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {

            while (sqlite3_step(queryStatement) == SQLITE_ROW) {
            
                let id = Int(sqlite3_column_int(queryStatement, 0))
            
                let employeeCString = sqlite3_column_text(queryStatement, 1)
                let employeeName = String(cString: employeeCString!)
            
                employees.updateValue(id, forKey: employeeName)
                print("\(id) " + employeeName)
            }

        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        
        return employees
        
    }
    
    func selectUser(){
        
        
        
    }
    
    func itExistsLocation(country: String, city: String, state: String, streetAdress: String, zipCode:  Int)->Int{
        //INSERT INTO Location (Id, Country, City, State, StreetAdress, ZipCode)
        var queryStatement: OpaquePointer? = nil
        let queryStatementString = "SELECT ID FROM Location WHERE Country = '\(country)' AND City = '\(city)' AND State = '\(state)' AND StreetAdress = '\(streetAdress)' AND ZipCode = '\(zipCode)';"
        var id : Int32? = nil
                  if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {

                  while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                     id = sqlite3_column_int(queryStatement, 0)
                  }

                } else {
                  print("SELECT statement could not be prepared")
                }
                sqlite3_finalize(queryStatement)
        if id == nil {
            return -1
        }
        return Int(id!)
        
        
    }
    
    func getAvailableEmployees(eventID: Int)->[String]{
        
        var queryStatement: OpaquePointer? = nil
           let queryStatementString = ""
           var employees = [String]()
                     if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {

                     while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                        sqlite3_column_int(queryStatement, 0)
                        employees.append("elem")
                     }

                   } else {
                     print("SELECT statement could not be prepared")
                   }
                   sqlite3_finalize(queryStatement)
        
        
        return employees
        
    }
    
    
    func printEmployee(){
           
           var queryStatement: OpaquePointer? = nil
           //(Id, EventName,Date,Duration,LocationID)
           let queryStatementString = "SELECT * FROM Link;"
           
                     if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {

                     while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                        let id = Int(sqlite3_column_int(queryStatement, 0))
                        
                        var employeeCString = sqlite3_column_text(queryStatement, 1)
                        var employeeName = String(cString: employeeCString!)
                        
                        
                        var employee2CString = sqlite3_column_text(queryStatement, 2)
                        var employee2Name = String(cString: employee2CString!)
                        
                        var employee3CString = sqlite3_column_text(queryStatement, 3)
                        var employee3Name = String(cString: employee3CString!)
                        
                        var employee4CString = sqlite3_column_text(queryStatement, 4)
                        var employee4Name = String(cString: employee4CString!)
                        
//                        var employee5CString = sqlite3_column_text(queryStatement, 5)
//                        var employee5Name = String(cString: employee5CString!)
                        
                       //print(employeeName)
                        //print(id)
                        print( employeeName + " " + employee2Name  + " " + employee3Name  + " " + employee4Name  )// + " " + employee5Name)
                        
                     }

                   } else {
                     print("SELECT statement could not be prepared")
                   }
                   sqlite3_finalize(queryStatement)
           
           
       }
    
}


class EventInfoObjectForEmployer{
    
    var eventName: String
    var employer: String
    var cost: Int
    
    init(eventName: String, employer: String, cost: Int) {
        self.eventName = eventName
        self.cost = cost
        self.employer = employer
    }
    
    
}

class EventInfoObjectForEmployee{
    
    var eventName: String
    var employee = [String]()
    var cost: Int
    
    init(eventName: String, employee: String, cost: Int) {
        self.eventName = eventName
        self.cost = cost
        self.employee.append(employee)
    }
    
    func addAnotherEmployee(employee: String){
        self.employee.append(employee)
    }
    
    
}

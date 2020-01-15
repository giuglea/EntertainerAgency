//
//  Inserts.swift
//  EntertainerAgency
//
//  Created by Andrei Giuglea on 05/01/2020.
//  Copyright © 2020 Andrei Giuglea. All rights reserved.
//

import Foundation
import Firebase
import SQLite3


extension Database{
    
   
    func insertEvent(eventName: String, duration: String, locationID: Int,date: String)->Int{
        
        let insertStatementString = "INSERT INTO Events (Id, EventName,Date,Duration,LocationID) VALUES (?, '\(eventName)', '\(duration)', '\(locationID)', '\(date)');"
        var insertStatement:OpaquePointer?=nil
        
           if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil)==SQLITE_OK{
           
               if sqlite3_step(insertStatement) == SQLITE_DONE {
                   print("Successfully inserted row.")
           
               } else {
                   print("Could not insert row.")
               }
            
           } else  {
               print("INSERT statement could not be prepared.")
           }
           sqlite3_finalize(insertStatement)
            return getLastInsertedID(tableName: "Events")
        ///PLUS FOREIGN KEY
    }
    
    
    func insertEmployee(employeeName: String, employeeSurname: String, gender: String, rating:  Double, phoneNumber: Int, locationID: Int)->Int{
        //EmployeeName CHAR(255) NOT NULL, EmployeeSurname CHAR(255), Gender CHAR(1)
        let insertStatementString = "INSERT INTO Employee (Id, EmployeeName, EmployeeSurname, Gender, Rating, PhoneNumber, LocationID) VALUES (?, '\(employeeName)', '\(employeeSurname)', '\(gender)', '\(rating)', '\(phoneNumber)', '\(locationID)');"
        var insertStatement:OpaquePointer?=nil
       
          if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil)==SQLITE_OK{
            
     
              if sqlite3_step(insertStatement) == SQLITE_DONE {
                  print("Successfully inserted row.")
                  
                 
                 
              } else {
                  print("Could not insert row.")
              }
             
          }
              
          else  {
              print("INSERT statement could not be prepared.")
              
          }
        sqlite3_finalize(insertStatement)
        return getLastInsertedID(tableName: "Employee")
               /// firebase
           
    }
    
    
    
    func insertEmployer(employerName: String, employerSurname: String, gender: String, rating: Double, phoneNumber: Int, locationID: Int)->Int{
        
            let insertStatementString = "INSERT INTO Employer (Id, EmployerName, EmployerSurname, Gender, Rating, PhoneNumber, LocationID) VALUES (?, '\(employerName)', '\(employerSurname)', '\(gender)', '\(rating)', '\(phoneNumber)', '\(locationID)');"
            var insertStatement:OpaquePointer?=nil
           
              if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil)==SQLITE_OK{
                  
         
                  if sqlite3_step(insertStatement) == SQLITE_DONE {
                      print("Successfully inserted row.")
                     
                     
                     
                  } else {
                      print("Could not insert row.")
                  }
                  //sqlite3_reset(insertStatement)
              }
                  
              else  {
                  print("INSERT statement could not be prepared.")
                  
              }
            sqlite3_finalize(insertStatement)

            return getLastInsertedID(tableName: "Employer")
                   
               
        }
    
    func insertLocation(country: String, city: String, state: String, streetAdress: String, zipCode:  Int)->Int{
        
        let insertStatementString = "INSERT INTO Location (Id, Country, City, State, StreetAdress, ZipCode) VALUES (?, '\(country)', '\(city)', '\(state)', '\(streetAdress)', '\(zipCode)');"
        var insertStatement:OpaquePointer?=nil
        let locationID = itExistsLocation(country: country, city: city, state: state, streetAdress: streetAdress, zipCode: zipCode)
        if(locationID != -1){
            print("Location already exists!  \n With id: \(locationID)")
            return locationID
        }
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil)==SQLITE_OK{
             
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
                                                  
            } else {
                print("Could not insert row.")
                }
                          
        }
                          
        else {
            print("INSERT statement could not be prepared.")
                          
        }
        sqlite3_finalize(insertStatement)
        
        return getLastInsertedID(tableName: "Location")
     
               
        
    }
    
    func insertBill(cost: Int, moneytype: String )->Int{
        
        let insertStatementString = "INSERT INTO Bill (Id, Cost, MoneyType) VALUES (?,'\(cost)', '\(moneytype)' );"
        var insertStatement:OpaquePointer?=nil
         
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil)==SQLITE_OK{
                
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("Successfully inserted row.")
                   
                   
                   
                } else {
                    print("Could not insert row.")
                }
                //sqlite3_reset(insertStatement)
        } else  {
            print("INSERT statement could not be prepared.")
                
            }
        sqlite3_finalize(insertStatement)
        return getLastInsertedID(tableName: "Bill")
                 
        
    }
    
    
    func insertLink(employeeID: Int, employerID: Int, eventID: Int, billID: Int){
        
          let insertStatementString = "INSERT INTO Link (Id, EmployeeID, EmployerID, EventID, BillID) VALUES (?, '\(employeeID)', '\(employerID)', '\(eventID)', '\(billID)');"
          var insertStatement:OpaquePointer?=nil
          
             if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil)==SQLITE_OK{
        
                 if sqlite3_step(insertStatement) == SQLITE_DONE {
                     print("Successfully inserted row.")
                     
                    
                    
                 } else {
                     print("Could not insert row.")
                 }
                
             }
                 
             else  {
                 print("INSERT statement could not be prepared.")
                 
             }
             sqlite3_finalize(insertStatement)
          ///PLUS FOREIGN KEY
    }
    
    func getID(tableName: String, data: String, tableColumn: String)->Int{//test
        var queryStatement: OpaquePointer? = nil
               var queryStatementString = "SELECT ID FROM \(tableName) WHERE '\(tableColumn)' = '\(data)';"
               var id: Int = 0
               if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {

                   while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                       id = Int(sqlite3_column_int(queryStatement, 0))
                          
                   }

               } else {
                   print("SELECT statement could not be prepared")
               }
               sqlite3_finalize(queryStatement)
           
               return id
    }
    
    
    func getLastInsertedID(tableName:  String)->Int{
        
        var queryStatement: OpaquePointer? = nil
        var queryStatementString = "SELECT MAX(id) from \(tableName)"
        var id: Int = 0
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {

            while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                id = Int(sqlite3_column_int(queryStatement, 0))
                   
            }

        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
    
        return id
        
    }
        
        
    
    
    
    
}

//
//  Databse.swift
//  EntertainerAgency
//
//  Created by Andrei Giuglea on 27/12/2019.
//  Copyright © 2019 Andrei Giuglea. All rights reserved.
//


import Foundation
import SQLite.Swift

class Database{

    var db: OpaquePointer? = nil
    var fileURL: Any? = nil

   
    init() {
        
    }


    
    func createEvent(){
    //(Id, EventName,Data,Duration,LocationID)
        var createTableString = "CREATE TABLE  Events (Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, EventName CHAR(255) UNIQUE NOT NULL, Date CHAR(255), Duration CHAR(255), LocationID INT NOT NULL, FOREIGN KEY (LocationID) REFERENCES Location (Id) ON DELETE CASCADE ON UPDATE NO ACTION);"
    var createTableStatement: OpaquePointer? = nil
    
    if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil)==SQLITE_OK{
        if sqlite3_step(createTableStatement)==SQLITE_DONE{
            print("Events Table created")
            
        }
        else {
            print("Events Table could not be created")
        }
    }
    else{
        print("CREATE TABLE statement could not be prepared")
    }
    sqlite3_finalize(createTableStatement)
}
    
    
    
      func createEmployee(){
        // Employee (Id, EmployeeName, EmployeeSurname, Gender, Rating, PhoneNumber, LocationID)
        var createTableString = "CREATE TABLE  Employee (Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, EmployeeName CHAR(255) NOT NULL, EmployeeSurname CHAR(255), Gender CHAR(1), Rating  REAL, PhoneNumber CHAR(255), LocationID INT NOT NULL, FOREIGN KEY (LocationID) REFERENCES Location (Id) ON DELETE CASCADE ON UPDATE NO ACTION);"
        var createTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil)==SQLITE_OK{
            if sqlite3_step(createTableStatement)==SQLITE_DONE{
                print("Employee Table created")
                
            }
            else {
                print("Employee Table could not be created")
            }
        }
        else{
            print("CREATE TABLE statement could not be prepared")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func createEmployer(){
           // Employee (Id, EmployeeName, EmployeeSurname, Gender, Rating, PhoneNumber, LocationID)
               var createTableString = "CREATE TABLE  Employer (Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, EmployerName CHAR(255) NOT NULL, EmployerSurname CHAR(255), Gender CHAR(1), Rating  REAL, PhoneNumber CHAR(255), LocationID INT NOT NULL, FOREIGN KEY (LocationID) REFERENCES Location (Id) ON DELETE CASCADE ON UPDATE NO ACTION);"
           var createTableStatement: OpaquePointer? = nil
           
           if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil)==SQLITE_OK{
               if sqlite3_step(createTableStatement)==SQLITE_DONE{
                   print("Events Table created")
                   
               }
               else {
                   print("Employee Table could not be created")
               }
           }
           else{
               print("CREATE TABLE statement could not be prepared")
           }
           sqlite3_finalize(createTableStatement)
       }
    
    // Location (Id, Country, City, State, StreetAdress, ZipCode
    func createLocation(){
            var createTableString = "CREATE TABLE  Location (Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, Country CHAR(255) NOT NULL, City CHAR(255) NOT NULL, State CHAR(255) NOT NULL, StreetAdress  CHAR(255) NOT NULL, ZipCode INT);"
            var createTableStatement: OpaquePointer? = nil
              
              if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil)==SQLITE_OK{
                  if sqlite3_step(createTableStatement)==SQLITE_DONE{
                      print("Location Table created")
                      
                  }
                  else {
                      print("Location Table could not be created")
                  }
              }
              else{
                  print("CREATE TABLE statement could not be prepared")
              }
              sqlite3_finalize(createTableStatement)
          }
    
    
    //Bill (Id, Cost, MoneyType)
    func createBill(){
      var createTableString = "CREATE TABLE  Bill (Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, Cost INT NOT NULL, MoneyType CHAR(65) );"
      var createTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil)==SQLITE_OK{
            if sqlite3_step(createTableStatement)==SQLITE_DONE{
                print("Bill Table created")
                
            }
            else {
                print("Bill Table could not be created")
            }
        }
        else{
            print("CREATE TABLE statement could not be prepared")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    //INSERT INTO Link (Id, EmployeeID, EmployerID, EventID, BillID)
    func createLink(){
      var createTableString = "CREATE TABLE  Link (Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, EmployeeID INT NOT NULL, EmployerID INT NOT  NULL, EventID INT NOT NULL, BillID INT NOT NULL, FOREIGN KEY (EmployeeID) REFERENCES Employee (Id), FOREIGN KEY (EmployerID) REFERENCES Employer (Id), FOREIGN KEY (EventID) REFERENCES Events (Id), FOREIGN KEY (BillID) REFERENCES Bill (Id));"
      var createTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil)==SQLITE_OK{
            if sqlite3_step(createTableStatement)==SQLITE_DONE{
                print("Link Table created")
                
            }
            else {
                print("Link Table could not be created")
            }
        }
        else{
            print("CREATE TABLE statement could not be prepared")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func createDatabase(){
        do{
            let manager = FileManager.default
            let documentURL = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("myDB.db")
            var rc = sqlite3_open(documentURL.path, &db)
            if rc == SQLITE_CANTOPEN{
                let bundleULR = Bundle.main.url(forResource: "myDB", withExtension: "db")!
                try manager.copyItem(at:bundleULR,to:documentURL)
            }
            if rc != SQLITE_OK{
                print("Error : \(rc)  ")
            }
        }
        catch{
        print(error)
        }
    
    

    }
    
    func openDatabase(){
        do{
            let manager = FileManager.default
            let documentURL = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("myDB.db")
                
            var rc = sqlite3_open_v2(documentURL.path, &db, SQLITE_OPEN_READWRITE, nil)
            if rc == SQLITE_CANTOPEN{
                let bundleULR = Bundle.main.url(forResource: "myDB", withExtension: "db")!
                try manager.copyItem(at:bundleULR,to:documentURL)
                }
                if rc != SQLITE_OK{
                    print("Error : \(rc)  ")
                }
            
        
        }
        catch{
            print(error)
        }
    }
    
    
    func dummyDb(){
        
        openDatabase()
        
         var billID = insertBill(cost: 100, moneytype: "Euro")
         var locationID = insertLocation(country: "Romania", city: "Constanta", state: "Constanta", streetAdress: "Razoare", zipCode: 900340)
         var eventID = insertEvent(eventName: "EventTest1", duration: "4:20", locationID: locationID, date: "04:12:2019")
         var employeeID = insertEmployee(employeeName: "Constantin", employeeSurname: "Surdu", gender: "M", rating: 3.5, phoneNumber: 745230789, locationID: locationID)
         var employerID = insertEmployer(employerName: "Eva", employerSurname: "Min", gender: "F", rating: 3.7, phoneNumber: 756239087, locationID: locationID)
        insertLink(employeeID: employeeID, employerID: employerID, eventID: eventID, billID: billID)
        
        
         billID = insertBill(cost: 500, moneytype: "RON")
         locationID = insertLocation(country: "Romania", city: "Bucuresti", state: "Bucuresti", streetAdress: "Fill", zipCode: 90540)
         eventID = insertEvent(eventName: "EventTest2", duration: "5:20", locationID: locationID, date: "09:12:2019")
        employeeID = insertEmployee(employeeName: "Milo", employeeSurname: "MiN3", gender: "F", rating: 4.0, phoneNumber: 35230789, locationID: locationID)
         employerID = insertEmployer(employerName: "Mario", employerSurname: "Cool", gender: "M", rating: 4.7, phoneNumber: 7239087, locationID: locationID)
        insertLink(employeeID: employeeID, employerID: employerID, eventID: eventID, billID: billID)
        
        
        locationID = insertLocation(country: "Romania", city: "Bucuresti", state: "Bucuresti", streetAdress: "Fill", zipCode: 90540)
                
        employeeID = insertEmployee(employeeName: "Altul", employeeSurname: "NimeniAltu", gender: "F", rating: 5.0, phoneNumber: 533657, locationID: locationID)
        insertLink(employeeID: employeeID, employerID: employerID, eventID: eventID, billID: billID)
        
        insertEmployee(employeeName: "NumeNou", employeeSurname: "Test", gender: "M", rating: 2.3, phoneNumber: 444, locationID: 2)
        
        billID = insertBill(cost: 5000, moneytype: "EURO")
        locationID = insertLocation(country: "Romania", city: "Bucuresti", state: "Stat", streetAdress: "Fill2", zipCode: 90040)
        eventID = insertEvent(eventName: "EventTestNR3", duration: "3:20", locationID: locationID, date: "09:12:2020")
        employeeID = insertEmployee(employeeName: "Mariu", employeeSurname: "Sika", gender: "F", rating: 2.9, phoneNumber: 35230789, locationID: locationID)
        employerID = insertEmployer(employerName: "Newb", employerSurname: "Andrei", gender: "M", rating: 4.9, phoneNumber: 7239087, locationID: locationID)
        insertLink(employeeID: employeeID, employerID: employerID, eventID: eventID, billID: billID)
        
        employeeID = insertEmployee(employeeName: "Laur", employeeSurname: "Entiu", gender: "M", rating: 2.9, phoneNumber: 35230789, locationID: locationID)
        insertLink(employeeID: employeeID, employerID: employerID, eventID: eventID, billID: billID)
        
        employeeID = insertEmployee(employeeName: "Catalin", employeeSurname: "Ent", gender: "M", rating: 3.9, phoneNumber: 35230789, locationID: locationID)
        insertLink(employeeID: employeeID, employerID: employerID, eventID: eventID, billID: billID)
        
        print(selectEmployeesForEvent(eventID: 2))
        
        
        
        
        
    }
    
}


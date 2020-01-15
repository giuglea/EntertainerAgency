//
//  Delete&Drops.swift
//  EntertainerAgency
//
//  Created by Andrei Giuglea on 05/01/2020.
//  Copyright © 2020 Andrei Giuglea. All rights reserved.
//

import Foundation
import SQLite3
import Firebase

extension Database{
    
    func dropTables(){
        dropTableWithName(tableName: "Events")
        dropTableWithName(tableName: "Employee")
        dropTableWithName(tableName: "Employer")
        dropTableWithName(tableName: "Bill")
        dropTableWithName(tableName: "Location")
        dropTableWithName(tableName: "Link")
        
    }
    
    func dropTableWithName(tableName: String){
        let destroyStatementString = "DROP TABLE \(tableName)"
        var destroyTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, destroyStatementString, -1, &destroyTableStatement, nil)==SQLITE_OK{
            if sqlite3_step(destroyTableStatement)==SQLITE_DONE{
                print("\(tableName) deleted")
                
            }
            else {
                print("\(tableName) could not be deleted")
            }
        }
        else{
            print("Delete \(tableName) statement could not be prepared")
        }
        sqlite3_finalize(destroyTableStatement)
    }
    
    func deleteUserAccount(userType: String, currentUser: String)->Bool{
        
        let user = Auth.auth().currentUser
        var isOk = true
        user?.delete { error in
          if let error = error {
            isOk = false
          } else {
            
          }
        }
        
        if isOk == false {return false}
        
       let deleteStatementString = "DELETE FROM  \(userType)s WHERE \(userType)Name = '\(currentUser)'"
       var deleteRowStatement: OpaquePointer? = nil
       
       if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteRowStatement, nil)==SQLITE_OK{
           if sqlite3_step(deleteRowStatement)==SQLITE_DONE{
               print("Row deleted")
               sqlite3_finalize(deleteRowStatement)
               return true
           }
           else {
               print("Row could not be deleted")
           }
       }
       else{
           print("Delete Row statement could not be prepared")
       }
        sqlite3_finalize(deleteRowStatement)
        return false
        
    }
    
    
    func deleteEvent(eventName: String){
        
        let deleteStatementString = "DELETE FROM  Events WHERE EventName = \(eventName)"
        var deleteRowStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteRowStatement, nil)==SQLITE_OK{
            if sqlite3_step(deleteRowStatement)==SQLITE_DONE{
                print("Row deleted")
                
            }
            else {
                print("Row could not be deleted")
            }
        }
        else{
            print("Delete Row statement could not be prepared")
        }
        sqlite3_finalize(deleteRowStatement)
        
        
    }
    
    
}

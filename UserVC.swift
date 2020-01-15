//
//  UserVC.swift
//  EntertainerAgency
//
//  Created by Andrei Giuglea on 27/12/2019.
//  Copyright © 2019 Andrei Giuglea. All rights reserved.
//

import Foundation
import UIKit



class UserVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var database = Database()
    var topUsers = [TopRatedUsers]()
    @IBOutlet weak var topUserTable: CustomTopRatedUsersCell!
    //topUsersCell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print()
        print(topUsers.count)
        return topUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "topUsersCell", for: indexPath) as! CustomTopRatedUsersCell
        cell.userNameLabel.text! = topUsers[indexPath.row].name
        print(topUsers[indexPath.row].name)
        cell.ratingLabel.text! = String(topUsers[indexPath.row].rating)
        return  cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database.openDatabase()
        topUsers = database.getTopRatedUsers()
        
        
    }
}

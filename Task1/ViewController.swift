//
//  ViewController.swift
//  Task1
//
//  Created by Piyush Bajaj on 3/20/19.
//  Copyright © 2019 Piyush Bajaj. All rights reserved.
//

import UIKit
import Firebase
var username = ""
var count = 1
class ViewController:  UITableViewController{


    

    
    @IBOutlet weak var TableViewRR: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("username").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            count = (value?["count"] as? Int)!
            self.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }


        // Do any additional setup after loading the view, typically from a nib.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Configure the cell..
        cell.textLabel?.text = "user\(indexPath.row + 1)"
        
        return cell
    }

    

    
    @IBAction func add(_ sender: UIButton) {
        let alert = UIAlertController(title: "User name you want to enter?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input the name here..."
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if let name = alert.textFields?.first?.text {
                var ref: DatabaseReference!
                ref = Database.database().reference()
                ref.child("username").setValue(["username": name])
                self.tableView.reloadData()
            }
        }))
        
    }
    
    
}


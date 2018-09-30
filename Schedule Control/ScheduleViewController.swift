//
//  ViewController.swift
//  Schedule Control
//
//  Created by Parth Ahuja on 9/19/18.
//  Copyright © 2018 Parth Ahuja. All rights reserved.
//

import UIKit

class FrontViewController: UITableViewController {
    var count = ["___ to ___ "]
    var schedule = [Int : String]()
    
    @IBAction func buttonPress(_ sender: Any) {
        //add rows
        count.append("___ to ___")
        tableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Schedule_Cell", for: indexPath)
        
        cell.textLabel?.font = UIFont(name: "Arial", size:25.0);
       
        cell.textLabel?.text = count[indexPath.row]
        
        return cell
}
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            count.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
}


//
//  ViewController.swift
//  Schedule Control
//
//  Created by Parth Ahuja on 9/19/18.
//  Copyright © 2018 Parth Ahuja. All rights reserved.
//

import UIKit

class FrontViewController: UITableViewController {
    //this stores the number of rows
    var count = [String]()
    var data_a = [Data_Model]()
    var data_b = [Data_Model]()
    var firstcall = true;
    
    
    //ADDING CELLS
    @IBAction func buttonPress(_ sender: Any) {
        //resetting data
        
        print("Button pressed!")
       
        //get last cell post update
        //let indexPath = IndexPath(row: count.count, section: 0)
        
        count.append("_")
        tableView.reloadData()
        
        for x in data_a{
            print(x.spot)
            print(x.hour )
            print(x.minutes)
            
        }
        //add new row
   

        //resetting model for redudancy 
        data_a.removeAll()
        data_b.removeAll()
        }

    
    override func viewWillDisappear(_ animated: Bool) {
        print("Navigating to next page")
        count.append("_")
        tableView.reloadData()
        
        for x in data_a{
            print(x.spot)
            print(x.hour )
            print(x.minutes)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Schedule_Cell", for: indexPath) as! CellController
    
            //custom data models
            let data_A = Data_Model()
            data_A.spot = "A"
            data_A.hour = Int(cell.time_A.text!)
            data_A.minutes = Int(cell.minutes_A.text!)
            
            data_a.append(data_A)
            
            let data_B = Data_Model()
            data_B.spot = "B"
            data_B.hour = Int(cell.time_B.text!)
            data_B.minutes = Int(cell.minutes_B.text!)
            
            data_b.append(data_B)
            
        return cell
}
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            count.remove(at: indexPath.row)
            //removing from data structure
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Schedule_Cell", for: indexPath) as! CellController
        
        
        tableView.deselectRow(at: indexPath, animated: false)//keyboard suspension
}
}

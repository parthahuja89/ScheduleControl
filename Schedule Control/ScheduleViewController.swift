//
//  ViewController.swift
//  Schedule Control
//
//  Created by Parth Ahuja on 9/19/18.
//  Copyright © 2018 Parth Ahuja. All rights reserved.
//

import UIKit
import RealmSwift

class FrontViewController: UITableViewController {
    //this stores the number of rows
    var count = [String]()
    var data_a = [Data_Model]()
    var data_b = [Data_Model]()

    let realm = try! Realm()
    
    //load in CRUD when appeared
    override func viewWillAppear(_ animated: Bool) {
        data_a.removeAll()
        data_b.removeAll()
        
        print("trying to get data from realm")
        let data = realm.objects(Data_Model.self)
        for x in data{ 
                if(x.spot == "A"){
                    data_a.append(x)
                }else{
                    data_b.append(x)
                }
            
        }
        tableView.reloadData()
    }

    //Store all the data in rows before navigating to next screen
    override func viewWillDisappear(_ animated: Bool) {
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
        return data_a.count
    }
    
    //populate data_a and data_b arrays 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Schedule_Cell", for: indexPath) as! CellController
           
            //get the data for each row from the back-end
            let curr_data = data_a[indexPath.row]
            
            cell.test_A.text = String(curr_data.hour.value!) + ":" + String(curr_data.minutes.value!)
            
            let curr_data_b = data_b[indexPath.row]
            
            cell.test_B.text = String(curr_data_b.hour.value!) + ":" + String(curr_data_b.minutes.value!)
            
        return cell
}
    
    
    
    //Deletes cells
    // TODO: Implement deleting in back-end
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

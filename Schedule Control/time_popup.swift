//
//  time_popup.swift
//  Schedule Control
//
//  Created by Parth Ahuja on 4/10/19.
//  Copyright © 2019 Parth Ahuja. All rights reserved.
//

import UIKit
import RealmSwift
class time_popup: UIViewController {

    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var done: UIButton!
    @IBOutlet weak var hour_A: UITextField!
    @IBOutlet weak var minute_A: UITextField!
    @IBOutlet weak var hour_B: UITextField!
    @IBOutlet weak var minute_B: UITextField!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    //Accepted and done 
    @IBAction func close(_ sender: Any)
    {
        let data_a = Data_Model()
        let data_b = Data_Model()
        if let test = hour_A.text { //safer
        data_a.spot = "A"
        data_a.postfix = nil
        data_a.assigned = true
        data_a.hour.value = Int(hour_A.text!)
        data_a.minutes.value = Int(minute_A.text!)
        }
        if let test = hour_B.text{
        data_b.spot = "B"
        data_b.postfix = nil
        data_b.assigned = true
        data_b.hour.value = Int(hour_B.text!)
        data_b.minutes.value = Int(minute_B.text!)
        }
        if(data_a.assigned! && data_b.assigned! ){
        do{
            try realm.write {
                realm.add(data_a)
                realm.add(data_b)
            }
        }catch{}
        }
        dismiss(self)
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

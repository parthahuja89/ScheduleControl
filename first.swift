//
//  first.swift
//  Schedule Control
//
//  Created by Parth Ahuja on 10/28/18.
//  Copyright © 2018 Parth Ahuja. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class First: UIViewController {
    
    @IBOutlet weak var first_address: UITextField!
    @IBOutlet weak var second_address: UITextField!
    @IBOutlet weak var main_event: UITextField!
    
    
    let realm = try! Realm()
    
   
    @IBOutlet weak var clicked: UIButton!
    
    @IBAction func moving(_ sender: Any) {
        let storing = Attributes()
        storing.address1 = first_address.text!
        storing.address2 = second_address.text!
        storing.event = main_event.text!
        print(first_address.text!)
        print(second_address.text!)
        
        do{
            try realm.write {
                realm.add(storing)
                
            }
        }catch{}
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

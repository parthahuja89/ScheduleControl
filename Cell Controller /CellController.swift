//
//  CellController.swift
//  Schedule Control
//
//  Created by Parth Ahuja on 10/14/18.
//  Copyright © 2018 Parth Ahuja. All rights reserved.
//

import UIKit

class CellController: UITableViewCell {
    //Spot A data
    @IBOutlet weak var time_A: UITextField!
    @IBOutlet weak var minutes_A: UITextField!
    
    //Spot B data
    @IBOutlet weak var time_B: UITextField!
    @IBOutlet weak var minutes_B: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}


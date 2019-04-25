//
//  Data_Model.swift
//  Schedule Control
//
//  Created by Parth Ahuja on 10/14/18.
//  Copyright © 2018 Parth Ahuja. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class Data_Model: Object{
     dynamic var hour = RealmOptional<Int>()
     dynamic var minutes = RealmOptional<Int>()
     dynamic var assigned : Bool? = false
     @objc dynamic var postfix : String? = ""
     @objc dynamic var spot : String? = ""
}

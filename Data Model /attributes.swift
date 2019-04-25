//
//  attributes.swift
//  Schedule Control
//
//  Created by Parth Ahuja on 10/28/18.
//  Copyright © 2018 Parth Ahuja. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class Attributes: Object{
    @objc dynamic var address1 : String? = ""
    @objc dynamic var address2 : String? = ""
    @objc dynamic var event : String? = ""
}

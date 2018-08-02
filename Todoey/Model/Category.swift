//
//  Category.swift
//  Todoey
//
//  Created by Gianmarco Belmonte on 01/08/18.
//  Copyright © 2018 Gianmarco Belmonte. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var hexValue: String = UIColor.randomFlat.hexValue()
    var items = List<Item>()
}

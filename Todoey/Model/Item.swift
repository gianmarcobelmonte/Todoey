//
//  Item.swift
//  Todoey
//
//  Created by Gianmarco Belmonte on 01/08/18.
//  Copyright © 2018 Gianmarco Belmonte. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var date: Date = Date()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

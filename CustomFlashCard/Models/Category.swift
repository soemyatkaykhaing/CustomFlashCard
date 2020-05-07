//
//  Category.swift
//  CustomFlashCard
//
//  Created by MacBook on 17/04/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var title: String? = ""
    @objc dynamic var date: Date? = nil
    @objc dynamic var desc: String? = ""
    let cards = List<Card>()
}

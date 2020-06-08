//
//  Letter.swift
//  CustomFlashCard
//
//  Created by MacBook on 23/05/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import RealmSwift

class Letter: Object {
    @objc dynamic var title: String? = ""
    @objc dynamic var date: Date? = nil
    @objc dynamic var desc: String? = ""
    let cards = List<Card>()
}

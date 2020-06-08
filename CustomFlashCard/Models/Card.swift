//
//  Card.swift
//  CustomFlashCard
//
//  Created by MacBook on 17/04/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import RealmSwift

class Card: Object {
    @objc dynamic var word : String? = ""
    @objc dynamic var meaning : String? = ""
    @objc dynamic var date : Date? = nil
    @objc dynamic var sentence : String? = ""
    var parentSubject = LinkingObjects(fromType: Category.self, property: "cards")
    
}

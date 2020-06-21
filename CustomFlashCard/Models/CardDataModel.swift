//
//  CardDataModel.swift
//  CustomFlashCard
//
//  Created by MacBook on 17/05/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import UIKit
struct CardsDataModel {
    
    var bgColor: UIColor
    var text : String
    var image : String
      
    init(bgColor: UIColor, text: String, image: String) {
        self.bgColor = bgColor
        self.text = text
        self.image = image
    
    }
}

//
//  TableViewCell.swift
//  CustomFlashCard
//
//  Created by MacBook on 23/05/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var btnAdd: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

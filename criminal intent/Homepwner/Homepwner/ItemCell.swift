//
//  ItemCell.swift
//  CriminalIntent
//
//  Created by Bell, Ryan J. on 12/6/17.
//  Copyright © 2017 Bell, Ryan J. All rights reserved.
//

import Foundation
import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.adjustsFontForContentSizeCategory = true
        serialNumberLabel.adjustsFontForContentSizeCategory = true
        valueLabel.adjustsFontForContentSizeCategory = true
    }
}

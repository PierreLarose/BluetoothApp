//
//  PeripheralTableViewCell.swift
//  BlueTrack
//
//  Created by Pierre Larose on 1/28/15.
//  Copyright (c) 2015 Pierre Larose. All rights reserved.
//

import UIKit

class PeripheralTableViewCell: UITableViewCell {

    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.uuidLabel.text = "We have a valid UUID"
        }
        // Configure the view for the selected state
    }

}

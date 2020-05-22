//
//  EventTableViewCell.swift
//  venue
//
//  Created by Dmitriy Butin on 22.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var nameEventLabel: UILabel!
    @IBOutlet weak var nickNameEventLabel: UILabel!
    @IBOutlet weak var discriptionEventLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

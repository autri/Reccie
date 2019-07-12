//
//  StepsTableViewCell.swift
//  Reccie
//
//  Created by Autri Baghkhanian on 7/7/19.
//  Copyright © 2019 Autri Baghkhanian. All rights reserved.
//

import UIKit

class StepsTableViewCell: UITableViewCell {

    @IBOutlet weak var orderOutlet: UILabel!
    @IBOutlet weak var stepNameOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

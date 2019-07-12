//
//  RecipeCellTableViewCell.swift
//  Reccie
//
//  Created by Autri Baghkhanian on 7/6/19.
//  Copyright © 2019 Autri Baghkhanian. All rights reserved.
//

import UIKit

class RecipeCellTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeServings: UILabel!
    @IBOutlet weak var recipeFavorite: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

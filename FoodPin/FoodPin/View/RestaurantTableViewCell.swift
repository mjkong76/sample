//
//  RestaurantTableViewCell.swift
//  FoodPin
//
//  Created by 공명진 on 2018. 4. 8..
//  Copyright © 2018년 mjkong. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var food: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var heart: UIImageView!
    @IBOutlet weak var more: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

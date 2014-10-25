//
//  FLDishTableViewCell.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

protocol FLDishTableViewCellDelegate {
    func dishCellSelected(cell: FLDishTableViewCell)
}

class FLDishTableViewCell: UITableViewCell {

    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishDescriptionLabel: UILabel!
    @IBOutlet weak var dishPrice: UILabel!
    @IBOutlet weak var priorityImage: UIImageView!
    
    var delegate: FLDishTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dishImage.layer.masksToBounds = true
        dishImage.layer.cornerRadius = dishImage.width / 2
        
        selectionStyle = .None
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWithDish(dish: FLDishEntity) {
        dishImage.image = UIImage(named: dish.dishImageURL)
        dishNameLabel.text = dish.dishName
        dishDescriptionLabel.text = dish.dishDescription
        dishPrice.text = "\(dish.dishPrice)$"
        
        switch dish.dishPriority {
        case 0:
            priorityImage.image = UIImage(named: "normalDish")
        case -1:
            priorityImage.image = UIImage(named: "unfaveDish")
        default:
            priorityImage.image = UIImage(named: "faveDish")
        }
    }
    
    @IBAction func addDishButtonAction(sender: UIButton) {
        delegate?.dishCellSelected(self)
    }
}

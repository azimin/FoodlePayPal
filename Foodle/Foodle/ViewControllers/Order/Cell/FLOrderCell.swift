//
//  FLOrderCell.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLOrderCell: UITableViewCell {

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishCountLabel: UILabel!
    @IBOutlet weak var dishPriceLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var tapToEditConstraint: NSLayoutConstraint!
    
    var isWeiter: Bool = false {
        didSet {
            progressView.progress = 0.0
            timeLeftLabel.text = "Tap to set time"
        }
    }
    
    var isReady: Bool = false {
        didSet {
            progressView.progress = 1.0
            timeLeftLabel.text = "Dish is ready"
        }
    }
    
    var enableSetCount: Bool = true {
        didSet {
            tapToEditConstraint.constant = (enableSetCount) ? 18 : 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .None
        dishNameLabel.adjustsFontSizeToFitWidth = true
        dishCountLabel.adjustsFontSizeToFitWidth = true
        progressView.progressTintColor = UIColor.appColor()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWithDish(dish: FLDishEntity) {
        dishNameLabel.text = dish.dishName
        dishImageView.image = UIImage(named: dish.dishImageURL)
        dishPriceLabel.text = "\(dish.dishPrice)$"
        dishCountLabel.text = "\(dish.count)"
        
    }
    
    
    @IBAction func tapToEditButtonAction(sender: UIButton) {
        
    }
}

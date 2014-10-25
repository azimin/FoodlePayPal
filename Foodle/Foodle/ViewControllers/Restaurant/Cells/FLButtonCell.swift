//
//  FLButtonCell.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLButtonCell: UITableViewCell {

    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var buttonTextLabel: UILabel!
    @IBOutlet weak var accesoryGreenView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.buttonTextLabel.textColor = UIColor.appColor()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.seperatorView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        // Configure the view for the selected state
    }
    
    func showAccesorise(show: Bool) {
        accesoryGreenView.hidden = show
    }
    
}

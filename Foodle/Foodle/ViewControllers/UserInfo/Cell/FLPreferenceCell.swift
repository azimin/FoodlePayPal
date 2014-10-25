//
//  FLPreferenceCell.swift
//  Foodle
//
//  Created by Alex Zimin on 26/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLPreferenceCell: UITableViewCell {

    @IBOutlet weak var buttonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        infoLabel.textColor = UIColor.appColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWithName(name: String, infoString: String, iconImageName: String) {
        nameLabel.text = name
        infoLabel.text = infoString
        buttonImageView.image = UIImage(named: iconImageName)
    }
}

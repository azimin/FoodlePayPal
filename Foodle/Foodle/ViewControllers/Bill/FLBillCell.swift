//
//  FLBillCell.swift
//  Foodle
//
//  Created by Alex Zimin on 26/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLBillCell: UITableViewCell {

    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var seperatorView: UIView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .None
        
        self.seperatorView.backgroundColor = UIColor(fromHexString: "729aae")
        self.cashLabel.textColor = UIColor(fromHexString: "729aae")
        self.nameLabel.textColor = UIColor(fromHexString: "729aae")
        self.infoLabel.textColor = UIColor(fromHexString: "729aae")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWithCash(cash: CGFloat) {
        nameLabel.hidden = true
        infoLabel.hidden = true
        cashLabel.hidden = false
        cashLabel.text = "\(cash)$"
    }
    
    func fillWithNameAndInfo(name: String, info: String) {
        nameLabel.text = name
        infoLabel.text = info
    }
    
    override func prepareForReuse() {
        nameLabel.hidden = false
        infoLabel.hidden = false
        cashLabel.hidden = true
    }
    
}

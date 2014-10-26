//
//  FLHeaderBillCell.swift
//  Foodle
//
//  Created by Alex Zimin on 26/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLHeaderBillCell: UITableViewCell {

    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var infoView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .None
        self.seperatorView.backgroundColor = UIColor(fromHexString: "729aae")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  FLGuestCell.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLGuestCell: UITableViewCell {

    @IBOutlet weak var tableBGView: UIView!
    @IBOutlet weak var tableNumberLabel: UILabel!
    @IBOutlet weak var guestNameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var newOrdersBGView: UIView!
    @IBOutlet weak var newOrdersLabel: UILabel!
    
    @IBOutlet weak var acceptButton: UIButton!
    
    
    @IBOutlet weak var nameConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .None
        
        tableBGView.layer.cornerRadius = tableBGView.width / 2
        newOrdersBGView.layer.cornerRadius = newOrdersBGView.width / 4
        newOrdersBGView.backgroundColor = UIColor.appColor()
        
        acceptButton.backgroundColor = UIColor.appColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWithUser() {
        
    }
    
    @IBAction func acceptButtonAction(sender: UIButton) {
        
    }
    
}

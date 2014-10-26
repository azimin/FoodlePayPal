//
//  FLTutorialButton.swift
//  Foodle
//
//  Created by Alex Zimin on 26/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

protocol FLTutorialButtonDelegate {
    func tutorialButton(button: FLTutorialButton, doCommand command: Int)
}

@IBDesignable
class FLTutorialButton: UIView {

    var imageView: UIImageView!
    var imageViewFrame: UIImageView!
    var label: UILabel!
    var delegate: FLTutorialButtonDelegate?
    
    @IBInspectable var imageName: String = "" {
        didSet {
            imageView.image = UIImage(named: imageName)
        }
    }
    
    var imageForFrame: String = "" {
        didSet {
            imageViewFrame.image = UIImage(named: imageForFrame)
        }
    }
    
    @IBInspectable var name: String = "" {
        didSet {
            label.text = name
        }
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        imageView = UIImageView(frame: CGRectMake(0, 0, bounds.width, bounds.width))
        self.addSubview(imageView)
        imageViewFrame = UIImageView(frame: imageView.bounds)
        imageViewFrame.image = nil
        self.addSubview(imageViewFrame)
        
        label = UILabel(frame: CGRectMake(0, bounds.width, bounds.width, bounds.height - bounds.width))
        label.textAlignment = .Center
        label.font = UIFont.mainFontWithSize(10)
        self.addSubview(label)
        
        let gesture = UITapGestureRecognizer(target: self, action: Selector("handleDoubleTapFrom:"))
        gesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(gesture)
        
        let onceGesture = UITapGestureRecognizer(target: self, action: Selector("handleTapFrom:"))
        onceGesture.numberOfTapsRequired = 1

        self.addGestureRecognizer(onceGesture)
    }
    
    var handlingBool = false
    
    func handleTapFrom(recognizer: UITapGestureRecognizer) {
        handlingBool = true

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(Int(CGFloat(NSEC_PER_SEC) * 0.15))), dispatch_get_main_queue()) {
            self.handleOneTap()
        }
        
        
    }
    
    func handleOneTap() {
        if (!handlingBool) {
            return
        }
        
        if (imageViewFrame.image == nil) {
            imageForFrame = "acceptFrame"
            imageName = name + "I"
        } else {
            imageViewFrame.image = nil
            imageName = name + "Id"
        }
        
        delegate?.tutorialButton(self, doCommand: 1)
    }
    
    func handleDoubleTapFrom(recognizer: UITapGestureRecognizer) {
        handlingBool = false
        if (imageViewFrame.image == nil || imageForFrame == "acceptFrame" ) {
            imageForFrame = "croseFrame"
            imageName = name + "Id"
        } else {
            imageViewFrame.image = nil
            imageName = name + "Id"
        }
        
        delegate?.tutorialButton(self, doCommand: 2)
        println("Dobule")
    }
    
    override func prepareForInterfaceBuilder() {
        
    }
}

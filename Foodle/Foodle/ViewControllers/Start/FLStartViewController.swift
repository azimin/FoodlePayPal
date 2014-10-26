//
//  FLStartViewController.swift
//  Foodle
//
//  Created by Alex Zimin on 26/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLStartViewController: FLBaseViewController, FLTutorialButtonDelegate {
    
    @IBOutlet weak var contentView: UIView!
    let buttonSize: CGFloat = 60
    @IBOutlet weak var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Welcome to Foodle"

        goButton.backgroundColor = UIColor.appColor()
        self.buttonHeight.constant = 0
        self.goButton.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var flag = false
    
    override func viewDidLayoutSubviews() {
        if (!flag) {
            flag = true
            fillContentView()
        }
    }
    
    func fillContentView() {
        var images = ["Fruits", "Green", "Spices", "Mushrooms", "Fish", "Vegetables", "Flour", "Cheese", "Chicken", "Beef", "Pork", "Rice"]
        let space = (self.view.width - buttonSize * 4) / 5
        
        //let fullSpace = (contentView.height - (space + (space + buttonSize + 20) * 3) - space) / 2
        
        for i in 0..<images.count {
            let index = CGFloat(i % 4)
            let yIndex = CGFloat(i / 4)
            let button = FLTutorialButton(frame: CGRectMake(space + (buttonSize + space) * index,  space + (space + buttonSize + 20) * yIndex, buttonSize, buttonSize + 20))
            button.imageName = "\(images[i])Id"
            button.name = images[i]
            button.delegate = self
            contentView.addSubview(button)
        }
    }
    
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!
    
    @IBAction func goButtonAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var aFlag = false
    
    func tutorialButton(button: FLTutorialButton, doCommand command: Int) {
        if !aFlag {
            aFlag = true
            self.goButton.hidden = false
            self.buttonHeight.constant = 50
            UIView.animateWithDuration(0.35, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

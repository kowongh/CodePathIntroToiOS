//
//  SettingsViewController.swift
//  tipCalculator
//
//  Created by Korin Wong-Horiuchi on 7/13/16.
//  Copyright © 2016 Korin Wong-Horiuchi. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController : UIViewController
{
    
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    @IBOutlet weak var colorModeLabel: UILabel!
    @IBOutlet weak var darkModeControl: UISegmentedControl!
    @IBOutlet weak var colorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //run animation on top view
        self.tipView.alpha = 0
        self.tipView.frame = CGRectMake(self.view.frame.width + 400, tipView.frame.origin.y, tipView.frame.width, tipView.frame.height)
        self.defaultTipControl.alpha = 0
        
        UIView.animateWithDuration(0.4, animations: {
            self.tipView.alpha = 1
            self.tipView.frame = CGRectMake(0, self.tipView.frame.origin.y, self.tipView.frame.width, self.tipView.frame.height)
            self.defaultTipControl.alpha = 1
        })
        
        //run animation on bottom view
        self.colorView.alpha = 0
        self.colorView.frame = CGRectMake(-500, colorView.frame.origin.y, colorView.frame.width, colorView.frame.height)
        self.darkModeControl.alpha = 0
        UIView.animateWithDuration(0.4, animations: {
            
            self.colorView.alpha = 1
            self.colorView.frame = CGRectMake(0, self.colorView.frame.origin.y, self.colorView.frame.width, self.colorView.frame.height)
            
            // This causes first view to fade in and second view to fade out
            self.darkModeControl.alpha = 1
        })

        //retrieve the saved index
        let defaults = NSUserDefaults.standardUserDefaults()
        let savedIndex = defaults.integerForKey("tipIndex")
        defaultTipControl.selectedSegmentIndex = savedIndex
        
        let colorMode = defaults.boolForKey("colorMode")
        darkModeControl.selectedSegmentIndex = Int(colorMode)
        changeViewColors(colorMode)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func changeViewColors(colorMode : Bool)
    {
        if !colorMode
        {
            //light
            tipView.backgroundColor = UIColor(red: 82.0/255.0, green: 190.0/255.0, blue: 128.0/255.0, alpha: 1)
            colorView.backgroundColor = UIColor(red: 71.0/255.0, green: 217.0/255.0, blue: 191.0/255.0, alpha: 1)
            defaultTipControl.tintColor = UIColor.whiteColor()
            darkModeControl.tintColor = UIColor.whiteColor()
            colorModeLabel.textColor = UIColor.blackColor()
            tipLabel.textColor = UIColor.blackColor()
        }
        else {
            //dark
            tipView.backgroundColor = UIColor.blackColor()
            colorView.backgroundColor = UIColor.blackColor()
            defaultTipControl.tintColor = UIColor.greenColor()
            darkModeControl.tintColor = UIColor.greenColor()
            colorModeLabel.textColor = UIColor.whiteColor()
            tipLabel.textColor = UIColor.whiteColor()
        }
    }
    
    @IBAction func colorThemeChanged(sender: AnyObject) {
        
        let colorMode = Bool(darkModeControl.selectedSegmentIndex)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(colorMode, forKey: "colorMode")
        defaults.synchronize()
        
        changeViewColors(colorMode)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    
        //save the selected index
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTipControl.selectedSegmentIndex, forKey: "tipIndex")
        defaults.synchronize()
    }
    
    
    
}
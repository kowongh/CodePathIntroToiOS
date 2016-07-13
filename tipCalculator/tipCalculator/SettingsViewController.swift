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
    
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //retrieve the saved index
        let defaults = NSUserDefaults.standardUserDefaults()
        let savedIndex = defaults.integerForKey("defaultIndex")
        
        defaultTipControl.selectedSegmentIndex = savedIndex
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    
        //save the selected index
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTipControl.selectedSegmentIndex, forKey: "defaultIndex")
        defaults.synchronize()
    }

}
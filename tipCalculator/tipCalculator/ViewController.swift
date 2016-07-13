//
//  ViewController.swift
//  tipCalculator
//
//  Created by Korin Wong-Horiuchi on 7/13/16.
//  Copyright © 2016 Korin Wong-Horiuchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var masterTipView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    @IBAction func billBeganEdit(sender: AnyObject) {
        
        self.masterTipView.alpha = 0
        self.masterTipView.frame = CGRectMake(-500, masterTipView.frame.origin.y, masterTipView.frame.width, masterTipView.frame.height)
        self.tipLabel.alpha = 0
        self.totalLabel.alpha = 0
        UIView.animateWithDuration(0.4, animations: {
            
            self.masterTipView.alpha = 1
            self.masterTipView.frame = CGRectMake(0, self.masterTipView.frame.origin.y, self.masterTipView.frame.width, self.masterTipView.frame.height)

            // This causes first view to fade in and second view to fade out
            self.tipLabel.alpha = 1
            self.totalLabel.alpha = 1
        })
        
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let savedIndex = defaults.integerForKey("defaultIndex")
        tipControl.selectedSegmentIndex = savedIndex

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
        
        view.endEditing(true)
    }

    @IBAction func calculateTip(sender: AnyObject) {
        
        let tipPercentages = [0.10, 0.20, 0.30]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
    }
}


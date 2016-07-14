//
//  ViewController.swift
//  tipCalculator
//
//  Created by Korin Wong-Horiuchi on 7/13/16.
//  Copyright © 2016 Korin Wong-Horiuchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billTipView: UIView!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var masterTipView: UIView!
    
    @IBOutlet weak var topTipLabel: UILabel!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    @IBOutlet weak var totalText: UILabel!
    @IBOutlet weak var tipText: UILabel!
    
    
    var billAmount : Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        billField.becomeFirstResponder()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        calculateTip(billField)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //get the tipIndex for the starting segment
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipIndex = defaults.integerForKey("tipIndex")
        tipControl.selectedSegmentIndex = tipIndex

        //get the nsdate object and see if it has been over 600 seconds/10 mins
        let timeSinceSave = defaults.objectForKey("timeOfSave") as? NSDate
        if let time = timeSinceSave
        {
            let elapsedTime = Int(NSDate().timeIntervalSinceDate(time))
            if elapsedTime < 600
            {
                //get bill amount and update UI
                billAmount = defaults.doubleForKey("billAmount")
                billField.text = String(format: "%.2f", billAmount)
            }
        }
        
        let colorMode = defaults.boolForKey("colorMode")
        if !colorMode
        {
            //light
            billTipView.backgroundColor = UIColor(red: 82.0/255.0, green: 190.0/255.0, blue: 128.0/255.0, alpha: 1)
            masterTipView.backgroundColor = UIColor(red: 71.0/255.0, green: 217.0/255.0, blue: 191.0/255.0, alpha: 1)
            tipControl.tintColor = UIColor.whiteColor()
            
            tipLabel.textColor = UIColor.blackColor()
            totalLabel.textColor = UIColor.blackColor()
            billLabel.textColor = UIColor.blackColor()
            topTipLabel.textColor = UIColor.blackColor()
            
            totalText.textColor = UIColor.blackColor()
            tipText.textColor = UIColor.blackColor()
        }
        else {
            //dark
            billTipView.backgroundColor = UIColor.blackColor()
            masterTipView.backgroundColor = UIColor.blackColor()
            tipControl.tintColor = UIColor.greenColor()
            
            tipLabel.textColor = UIColor.whiteColor()
            totalLabel.textColor = UIColor.whiteColor()
            billLabel.textColor = UIColor.whiteColor()
            topTipLabel.textColor = UIColor.whiteColor()
            
            totalText.textColor = UIColor.whiteColor()
            tipText.textColor = UIColor.whiteColor()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let nowTime = NSDate()
        defaults.setValue(nowTime, forKey: "timeOfSave")
        defaults.setValue(billAmount, forKey: "billAmount")

    }
    
    @IBAction func billBeganEdit(sender: AnyObject) {
        
        //run animation on top view
        self.billTipView.alpha = 0
        self.billTipView.frame = CGRectMake(self.view.frame.width + 400, billTipView.frame.origin.y, masterTipView.frame.width, billTipView.frame.height)
        self.billField.alpha = 0
        self.tipControl.alpha = 0

        UIView.animateWithDuration(0.4, animations: {
            self.billTipView.alpha = 1
            self.billTipView.frame = CGRectMake(0, self.billTipView.frame.origin.y, self.billTipView.frame.width, self.billTipView.frame.height)
            self.billField.alpha = 1
            self.tipControl.alpha = 1
        })
        
        //run animation on bottom view
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        let tipPercentages = [0.10, 0.20, 0.30]
        
        billAmount = Double(billField.text!) ?? 0
        let tip = billAmount * tipPercentages[tipControl.selectedSegmentIndex]
        let total = billAmount + tip
        
        let formatter = NSNumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "es_ES")
        
        let tipString = formatter.stringFromNumber(tip)
        let totalString = formatter.stringFromNumber(total)
        
        tipLabel.text = tipString
        totalLabel.text = totalString
    }
}


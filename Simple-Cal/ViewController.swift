//
//  ViewController.swift
//  Simple-Cal
//
//  Created by Matthew Chess on 2/25/15.
//  Copyright (c) 2015 Matthew Chess. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    
    var userIsTypingANumber = false
    
    var brain = CalBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
       // println("digit = \(digit)")
        if userIsTypingANumber{
        display.text = display.text! + digit
        }else{
            display.text = digit
            userIsTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsTypingANumber{
            enter()
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
   
    
        var displayValue: Double{
            get {
                return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
            }
            set {
                display.text = "\(newValue)"
                userIsTypingANumber = false
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


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
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        println("digit = \(digit)")
        if userIsTypingANumber{
        display.text = display.text! + digit
        }else{
            display.text = digit
            userIsTypingANumber = true
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func operate(sender: UIButton) {
        
        let operation = sender.currentTitle!
        if userIsTypingANumber {
            enter()
        }
        switch operation{
        case "×": preformOperation({ $0 * $1 })
        case "÷": preformOperation({$1 / $0})
        case "+": preformOperation({$0 + $1})
        case "−": preformOperation({$1 - $0})
        default: break
        }
    }
    
    func preformOperation(operation: (Double, Double) -> Double ){
        
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
            }
    }

    
    @IBAction func enter() {
        userIsTypingANumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
        
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


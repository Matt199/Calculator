//
//  ViewController.swift
//  Calculator
//
//  Created by Mateusz Kopacz on 23.08.2016.
//  Copyright © 2016 Mateusz Kopacz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var userIsInTheMiddleOfTyppingANumber = false
    
    
    
    @IBOutlet weak var displayLabel: UILabel!
    
    
    @IBAction func pushedDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if (userIsInTheMiddleOfTyppingANumber && digit != ".") || (digit == "." && displayLabel.text?.rangeOfString(".") != nil) {
            

                displayLabel.text = displayLabel.text! + digit
        } else {
            displayLabel.text = digit
            userIsInTheMiddleOfTyppingANumber = true
        }
        
    }
    
    var displayValue:Double{
        get {
            return Double(displayLabel.text!)!
        }
        set {
            displayLabel.text = String(newValue)
        }
        
    }
    
    var brain = CalculatorBrain()
    
    @IBAction func pushedOperator(sender: UIButton) {
        
        if userIsInTheMiddleOfTyppingANumber{
            brain.performOperand(displayValue)
        }
        if let mathematicalOperator = sender.currentTitle{
         
            brain.setSymbol(mathematicalOperator)
            userIsInTheMiddleOfTyppingANumber = false
        }
        displayValue = brain.result
        print(displayValue)
    }
    
}


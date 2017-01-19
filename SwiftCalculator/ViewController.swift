//
//  ViewController.swift
//  SwiftCalculator
//
//  Created by Alien on 6/01/2017.
//  Copyright © 2017 Alien. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet private var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    private var userPressedDecimelPoint = false
    
    private var brain = CalculatorBrain()

    @IBAction private func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        

        if userIsInTheMiddleOfTyping && !userPressedDecimelPoint {
          display.text = display.text! + digit
            if digit == "." {
                userPressedDecimelPoint = true
            }
        }
        else if userIsInTheMiddleOfTyping && userPressedDecimelPoint {
            if digit != "." {
                display.text = display.text! + digit
            }
            else{
                print("user has pressed decimal point twice, ignoring this one")
            }
            userIsInTheMiddleOfTyping = true
            
        }
        else if !userIsInTheMiddleOfTyping && userPressedDecimelPoint {
            display.text! = digit
            userIsInTheMiddleOfTyping = true
        }
        else{
            display.text! = digit
            userIsInTheMiddleOfTyping = true
        }
        
    }
    
    
    private var displayValue:Double{
        get {
            return Double(display.text!)!
        }
        
        set {
            display.text = String(newValue)
    
        }
    }
    
    
    
   

    @IBAction private func performOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
            userPressedDecimelPoint = false
        }
        
        if let mathematicalSymbol = sender.currentTitle
        {
            brain.performOperation(symbol: mathematicalSymbol)
        }
     
       
        displayValue = brain.result
        
    }
    
    
    
    
    
    
}






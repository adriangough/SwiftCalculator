//
//  ViewController.swift
//  SwiftCalculator
//
//  Created by Alien on 6/01/2017.
//  Copyright © 2017 Alien. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false

    @IBAction func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!

        if userIsInTheMiddleOfTyping {
          display.text = display.text! + digit
        }
        else{
            display.text! = digit
        }
        
        userIsInTheMiddleOfTyping = true
        
        
    }
   

    @IBAction func performOperation(_ sender: UIButton) {
        if let mathematicalSymbol = sender.currentTitle
        {
            if mathematicalSymbol == "π" {
                display.text = String(M_PI)
            }
        }
        
        userIsInTheMiddleOfTyping = false
        
    }
    
    
    
    
    
    
}






//
//  CalculatorBrain.swift
//  SwiftCalculator
//
//  Created by Alien on 8/01/2017.
//  Copyright © 2017 Alien. All rights reserved.
//

import Foundation



class CalculatorBrain {
    private var accumulator = 0.0
    
    func setOperand(operand: Double){
        descriptionOfBrain (op: String(operand))
        accumulator = operand
        
    }
    
    
    enum Operation  {
        
        case constant (Double)
        case unaryOperation ((Double) -> Double)
        case binaryOperation ((Double, Double) -> Double)
        case equals
    }

    
    
    
    
    var operations: Dictionary<String,Operation> = [
                      "π" : Operation.constant (M_PI),
                      "e" : Operation.constant (M_E),
                      "COS": Operation.unaryOperation (cos),
                      "SIN": Operation.unaryOperation (sin),
                      "√": Operation.unaryOperation (sqrt),
                      "✖️" : Operation.binaryOperation({ $0*$1 }),
                      "➗" : Operation.binaryOperation({ $0/$1 }),
                      "➖" : Operation.binaryOperation({ $0-$1 }),
                      "➕" : Operation.binaryOperation({ $0+$1 }),
                      "=" :Operation.equals
                               ] // This is a dictionary
    
    
    private var pending: PendingBinaryOperation?
    
    struct PendingBinaryOperation{
        
        var firstOperand: Double // this will be accumulator so far
        var binaryOperation: (Double, Double) -> Double
        
        
    }
    
 
    private func executePendingBinaryOperation()
    {
        if pending != nil{
            accumulator = pending!.binaryOperation(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var descriptionArray = [String]()

    private func descriptionOfBrain(op:String){
        if op != "=" || op != "..."  {
            descriptionArray.append(op)
            print ("\(descriptionArray)")
        }
        
    }
    
    
    func performOperation(symbol: String){
        descriptionOfBrain(op: symbol)
        if let operation = operations[symbol]{
            switch operation {
            case Operation.constant(let associatedConstantValue): accumulator = associatedConstantValue
            case .unaryOperation(let associatedUnaryOperation): accumulator = associatedUnaryOperation(accumulator)
            case .binaryOperation(let associatedBinaryOperation):
                executePendingBinaryOperation()
                pending = PendingBinaryOperation.init(firstOperand: accumulator, binaryOperation: associatedBinaryOperation)
    
            case .equals:
                executePendingBinaryOperation()
                descriptionArray.removeAll()
            }
        }
        
    }
    
    var result: Double{
        get {
            return accumulator
            
        }
    }

}

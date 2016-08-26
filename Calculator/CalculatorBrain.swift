//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Mateusz Kopacz on 24.08.2016.
//  Copyright © 2016 Mateusz Kopacz. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    var acumulator = 0.0
    
    func performOperand(operand:Double) {
        
        acumulator = operand
        
    }
    
    var operators: Dictionary<String,Operator> = [
        
        "∏" : Operator.Constant(M_PI),
        "√" : Operator.UnaryOperator(sqrt),
        "sin" : Operator.UnaryOperator(sin),
        "cos" : Operator.UnaryOperator(cos)
        
    ]
    
    enum Operator {
        case Constant(Double)
        case UnaryOperator((Double) -> Double)
        case BinaryOperator
        case Equal
    }
    
    func setSymbol(symbol:String) {
        
        if let symbols = operators[symbol]{
        switch symbols {
        case .Constant(let value):
            acumulator = value
        case .UnaryOperator(let unaryFunction):
            acumulator = unaryFunction(acumulator)
       
        default:
            break
        }
        }
        
       
        
    }
    
    var result:Double{
        get{
            return acumulator
        }
    }
    
}
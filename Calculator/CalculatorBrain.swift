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
        "cos" : Operator.UnaryOperator(cos),
        "×" : Operator.BinaryOperator({$0 * $1}),
        "÷" : Operator.BinaryOperator({$0 / $1}),
        "+" : Operator.BinaryOperator({$0 + $1}),
        "−" : Operator.BinaryOperator({$0 - $1}),
        "%" : Operator.BinaryOperator({$0 % $1}),
        "±" : Operator.UnaryOperator({-$0}),
        "AC" : Operator.Constant(0.0),
        "=" : Operator.Equal
    ]
    
    enum Operator {
        case Constant(Double)
        case UnaryOperator((Double) -> Double)
        case BinaryOperator((Double, Double) -> Double)
        case Equal
    }
    
    
    var pending:PendingBinaryOperator?
    
    struct PendingBinaryOperator {
        var binaryOperator: (Double,Double) -> Double
        var firstOperand: Double
    }
    
    func executePendingBinaryOperator(){
        if pending != nil{
            acumulator = pending!.binaryOperator(pending!.firstOperand, acumulator)
            pending = nil
        }
        
    }
    
    
    func setSymbol(symbol:String) {
        
        if let symbols = operators[symbol]{
            switch symbols {
            case .Constant(let value):
                acumulator = value
            case .UnaryOperator(let unaryFunction):
                acumulator = unaryFunction(acumulator)
            case .BinaryOperator(let binaryFunction):
                executePendingBinaryOperator()
                pending = PendingBinaryOperator(binaryOperator: binaryFunction, firstOperand: acumulator)
            case .Equal:
                executePendingBinaryOperator()
            }
        }
        
        
        
    }
    
    var result:Double{
        get{
            return acumulator
        }
    }
    
}
//
//  CalBrain.swift
//  Simple-Cal
//
//  Created by Matthew Chess on 3/14/15.
//  Copyright (c) 2015 Matthew Chess. All rights reserved.
//

import Foundation

class CalBrain {
    
     private enum Op: Printable{
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperaitot(String, (Double, Double) -> Double)
        
        var description: String {
            get{
                switch self{
                case .Operand(let operand):
                        return "\(operand)"
                case .UnaryOperation(let symbol, _):
                        return "\(symbol)"
                case .BinaryOperaitot(let symbol, _):
                        return "\(symbol)"
                }
            }
        }
    }
    
    
    private var opStack = [Op]()
    
    private var knownOps = [String:Op]()
    
    init(){
        func learnOp(op: Op){
            knownOps[op.description] = op
        }
        learnOp(Op.BinaryOperaitot("×", *))
        learnOp(Op.BinaryOperaitot("÷") { $1 / $0 })
        learnOp(Op.BinaryOperaitot("+", +))
        learnOp(Op.BinaryOperaitot("−") { $1 - $0 })
        learnOp(Op.UnaryOperation("√", sqrt))
        learnOp(Op.UnaryOperation("sin", sin))
        learnOp(Op.UnaryOperation("cos", cos))

    }
    
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]){
        
        if(!ops.isEmpty){
            var remainingOps = ops
            let op = remainingOps.removeLast()
            println(op)
            switch op {
            case .Operand(let operand):
                println(operand)
                return (operand, remainingOps)
            case  .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result{
                return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperaitot(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                println(remainingOps)
                if let operand1 = op1Evaluation.result{
                    println(operand1)
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    println(op2Evaluation)
                    if let operand2 = op2Evaluation.result{
                        println(operation(operand1, operand2))
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double?{
        let (result, remainder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double?{
        
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
        return evaluate()
    }
    
    func clearStack() {
        opStack = []
        println(opStack)
        
    }
}
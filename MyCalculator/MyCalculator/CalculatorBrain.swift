//
//  File.swift
//  MyCalculator
//
//  Created by Hao WU on 10/29/16.
//  Copyright © 2016 Hao WU. All rights reserved.
//

import Foundation

class CalculatorModel{
    var accumulator:Double = 0.0
    enum Operation{
        case constant(Double)
        case unaryOperation((Double)->Double)
        case binaryOperation ((Double,Double)->Double)
        case equals
    }
    var signMapToOperation : Dictionary <String, Operation> = [
        "cos": Operation.unaryOperation(cos),
        "√": Operation.unaryOperation(sqrt),
        "+": Operation.binaryOperation({$0+$1}),
        "-": Operation.binaryOperation({$0-$1}),
        "*": Operation.binaryOperation({$0*$1}),
        "/": Operation.binaryOperation({$0/$1}),
        "=":Operation.equals
    ]
    struct PendingInfoStruct {
        var pendingOperation : (Double,Double)->Double
        var pendingAccumulator : Double
    }
    var pending : PendingInfoStruct? // It is optional
    func performOperation (inputSign:String) {
        //print (accumulator)
        //print (cos(90.0))
        if let operation = signMapToOperation[inputSign]{
            switch operation {
            case .unaryOperation (let f):// f is the real function
                //print (f(accumulator))
                accumulator = f(accumulator)
            case .binaryOperation(let f):// f will capture the binaryfunction
                performBinaryOperation(ff: f)
            case .equals:
                performEqualOperation()
            default:
                break
            }
        }
    }
    
    func performBinaryOperation (ff: @escaping (Double,Double)->Double){

        if pending==nil{
            pending=PendingInfoStruct(pendingOperation: ff, pendingAccumulator : accumulator)        }
        else{//There is a pending structure, we should finish the first pending
            accumulator=pending!.pendingOperation(pending!.pendingAccumulator,accumulator)
            pending=PendingInfoStruct(pendingOperation: ff, pendingAccumulator : accumulator)
        }
    }
    
    func performEqualOperation (){
        if pending != nil{
            accumulator=pending!.pendingOperation(pending!.pendingAccumulator,accumulator)
            pending=nil
        }
    }
    
    func clear(){
        pending=nil
        accumulator=0.0
    }
    
    func setAccumulator(displayValue : String){
        accumulator = Double(displayValue)!
    }
    
    func getResult() -> Double{
        return accumulator
    }
}

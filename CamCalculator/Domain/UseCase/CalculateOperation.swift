//
//  CalculateOperation.swift
//  CamCalculator
//
//  Created by Prasetya on 20/05/23.
//

import Foundation

protocol CalculateOperation {
    func call(input: String) -> String
}

class CalculateOperationImpl: CalculateOperation {
    func call(input: String) -> String {
        let expressionString = input
            .replacingOccurrences(of: "x", with: "*")
            .replacingOccurrences(of: ":", with: "/")
        
        let mathExpression = NSExpression(format: expressionString)
        
        if let result = mathExpression.expressionValue(with: nil, context: nil) as? NSNumber {
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumFractionDigits = 0
            numberFormatter.maximumFractionDigits = 2
            
            return numberFormatter.string(from: result) ?? "0"
        }
        
        return "0"
    }
}

//
//  Calculator.swift
//  Calculator
//
//  Created by Nail Tunay ÖKSÜZ on 29.07.2022.
//

import Foundation

struct Calculator{
    
    
    private struct ArithmeticExpression: Equatable {
        var number: Decimal
        var operation: ArithmeticOperation
        
        func evaluate(with secondNumber: Decimal) -> Decimal {
            switch operation {
            case .addition:
                return number + secondNumber
            case .subtraction:
                return number - secondNumber
            case .multiplication:
                return number * secondNumber
            case .division:
                return number / secondNumber
            }
        }
    }
    private var carryingNegative: Bool = false
    private var carryingDecimal: Bool = false
    private var carryingZeroCount: Int = 0
    private var pressedClear: Bool = false
    private var newNumber: Decimal? {
            didSet {
                guard newNumber != nil else { return }
                carryingNegative = false
                carryingDecimal = false
                carryingZeroCount = 0
                pressedClear = false
            }
        }
    private var expression: ArithmeticExpression?
    private var result: Decimal?
    var showAllClear: Bool {
            newNumber == nil && expression == nil && result == nil || pressedClear
        }
    
    var displayText: String {
        return getNumberString(forNumber: number, withCommas: true)
    }
    var number: Decimal? {
            if pressedClear || carryingDecimal {
                return newNumber
            }
            return newNumber ?? expression?.number ?? result
        }
    mutating func setDigit(_ digit: Digit) {
            if containsDecimal && digit == .zero {
                carryingZeroCount += 1
            } else if canAddDigit(digit) {
                let numberString = getNumberString(forNumber: newNumber)
                newNumber = Decimal(string: numberString.appending("\(digit.rawValue)"))
            }
        }
    
    mutating func setOperation(_ operation: ArithmeticOperation) {
        
        guard var number = newNumber ?? result else { return }
        
        if let existingExpression = expression {
            number = existingExpression.evaluate(with: number)
        }
        
        expression = ArithmeticExpression(number: number, operation: operation)
        
        newNumber = nil
    }
    func operationIsHighlighted(_ operation: ArithmeticOperation) -> Bool {
        return expression?.operation == operation && newNumber == nil
    }
    
    mutating func toggleSign() {
        if let number = newNumber {
            newNumber = -number
            return
        }
        if let number = result {
            result = -number
            return
        }
        
        carryingNegative.toggle()
    }
    
    mutating func setPercent() {
        // 1.
        if let number = newNumber {
            // 2.
            newNumber = number / 100
            return
        }
        
        // 1.
        if let number = result {
            // 2.
            result = number / 100
            return
        }
    }
    
    mutating func setDecimal() {
            // 1.
            if containsDecimal { return }
            // 2.
            carryingDecimal = true
        }
    
    mutating func evaluate() {
        // 1.
        guard let number = newNumber, let expressionToEvaluate = expression else { return }
        // 2.
        result = expressionToEvaluate.evaluate(with: number)
        // 3.
        expression = nil
        newNumber = nil
    }
    
    mutating func allClear() {
            newNumber = nil
            expression = nil
            result = nil
            carryingNegative = false
            carryingDecimal = false
            carryingZeroCount = 0
        }
    
    mutating func clear() {
            newNumber = nil
            carryingNegative = false
            carryingDecimal = false
            carryingZeroCount = 0
            
            pressedClear = true
        }
    
    private func getNumberString(forNumber number: Decimal?, withCommas: Bool = false) -> String {
            var numberString = (withCommas ? number?.formatted(.number) : number.map(String.init)) ?? "0"
            
            if carryingNegative {
                numberString.insert("-", at: numberString.startIndex)
            }
            
            if carryingDecimal {
                numberString.insert(".", at: numberString.endIndex)
            }
            
            
            if carryingZeroCount > 0 {
                numberString.append(String(repeating: "0", count: carryingZeroCount))
            }
            
            return numberString
        }
    private var containsDecimal: Bool {
        return getNumberString(forNumber: number).contains(".")
    }
    private func canAddDigit(_ digit: Digit) -> Bool {
        return number != nil || digit != .zero
    }
}

//
//  ArithmeticOperation.swift
//  Calculator
//
//  Created by Nail Tunay ÖKSÜZ on 28.07.2022.
//

import Foundation
enum ArithmeticOperation: CaseIterable, CustomStringConvertible {
    case addition, subtraction, multiplication, division
    
    var description: String {
        switch self {
        case .addition:
            return "+"
        case .subtraction:
            return "−"
        case .multiplication:
            return "×"
        case .division:
            return "÷"
        }
    }
}

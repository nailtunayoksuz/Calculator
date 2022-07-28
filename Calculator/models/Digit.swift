//
//  Digit.swift
//  Calculator
//
//  Created by Nail Tunay ÖKSÜZ on 28.07.2022.
//

import Foundation

enum Digit : Int , CaseIterable, CustomStringConvertible{
case zero, one, two, three, four, five, six, seven, eight, nine
    
    var description: String {
        "\(rawValue)"
    }
}


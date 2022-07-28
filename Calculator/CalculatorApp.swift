//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Nail Tunay ÖKSÜZ on 28.07.2022.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorView()
                .environmentObject(CalculatorView.ViewModel())
        }
    }
}

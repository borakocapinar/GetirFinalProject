//
//  NumberFormatter.swift
//  GetirFinalProject
//
//  Created by BORA KOCAPINAR on 23.04.24.
//

import Foundation

extension NumberFormatter {
    static let turkishLiraFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₺"
        formatter.currencyDecimalSeparator = ","
        formatter.currencyGroupingSeparator = "."
        formatter.locale = Locale(identifier: "tr_TR")
        return formatter
    }()
}

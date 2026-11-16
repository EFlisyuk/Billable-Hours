//
//  DoubleExtension.swift
//  Billable Hours
//
//  Created by Елизавета Флисюк on 14.11.2026.
//

import Foundation

extension Double {
    func rounded(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        return (self * multiplier).rounded() / multiplier
    }
}

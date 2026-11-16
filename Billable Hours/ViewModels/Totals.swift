//
//  Totals.swift
//  Billable Hours
//
//  Created by Елизавета Флисюк on 16.11.2026.
//

import Foundation

enum Totals {

    static func sumDurations(_ calculations: [HoursFieldsModel]) -> String {
        var sum = 0
        for row in calculations {
            if let h = Int(row.hoursStr),
               let m = Int(row.minutesStr),
               let s = Int(row.secondsStr) {
                let sumRow = h * 3600 + m * 60 + s
                sum += sumRow
            }
        }
        
        let hours = (sum / 3600)
        let min = (sum / 60) - hours * 60
        let sec = sum % 60

        return String(format: "%d:%02d:%02d", hours, min, sec)
    }

    static func sumHours(_ calculations: [HoursFieldsModel])-> Double {
        calculations.reduce(0) {$0 + $1.resultDigit}
    }

    static func rate(_ text: String) -> Double? {
        Double(text.replacingOccurrences(of: ",", with: "."))
    }

    static func sumEarnings(_ hourlyRate: String, _ calculations: [HoursFieldsModel]) -> Double {
        var totalEarnings = 0.0
        if let rate = rate(hourlyRate) {
            for result in calculations {
                let earnings = result.resultDigit * rate
                totalEarnings += earnings
            }
        }
        return totalEarnings
    }
}

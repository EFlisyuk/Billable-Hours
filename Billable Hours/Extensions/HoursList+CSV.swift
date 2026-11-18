//
//  HoursList+CSV.swift
//  Billable Hours
//
//  Created by Елизавета Флисюк on 17.11.2026.
//

import Foundation

extension HoursList {
    func exportCSV() -> String {
        let rate = Totals.rate(hourlyRate) ?? 0
        var csv = "Duration;Hours;Earnings;Hourly Rate\n"
        for row in listResults {
            let earnings = rate > 0 ? String(format: "%.2f", locale: Locale.current, row.resultDigit * rate) : ""
            csv += "\(row.resultString);\(String(format: "%.3f", locale: Locale.current, row.resultDigit));\(earnings);\(rate)\n"
        }
        return csv
    }

    func csvURL() -> URL {
        let csv = exportCSV()
        let url = FileManager.default.temporaryDirectory
            .appending(component: "\(name).csv", directoryHint: .notDirectory)
        try? csv.write(to: url, atomically: true, encoding: .utf8)
        return url
    }
}

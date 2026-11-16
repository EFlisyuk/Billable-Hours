//
//  Billable_HoursTests.swift
//  Billable HoursTests
//
//  Created by Елизавета Флисюк on 10/07/2026.
//

import Testing
@testable import Billable_Hours

struct Billable_HoursTests {

    @Test func calculate() {
        let model = HoursFieldsModel()
        #expect(model.calculateHours("0", "30", "0") == 0.5)
    }

    @Test func validation() {
        let testCalculation = HoursFieldsModel()
        #expect(testCalculation.isValidMinutes("65") == false)
        #expect(testCalculation.isValidMinutes("59") == true)
        #expect(testCalculation.isValidSeconds("59") == true)
        #expect(testCalculation.isValidSeconds("60") == false)
        #expect(testCalculation.isValidHours("1000") == false)
        #expect(testCalculation.isValidHours("999") == true)
        #expect(testCalculation.isValidHours("-999") == false)
    }

    @Test func totals() {
        let rows = [
            HoursFieldsModel(hoursStr: "11", minutesStr: "11", secondsStr: "11", resultDigit: 11.186),
            HoursFieldsModel(hoursStr: "11", minutesStr: "32", secondsStr: "54", resultDigit: 11.548)
        ]

        #expect(Totals.sumDurations(rows) == "22:44:05")
        #expect(Totals.sumEarnings("1400", rows).rounded(to: 2) == 31827.6)
        #expect(Totals.rate("40,5") == 40.5)
    }
}

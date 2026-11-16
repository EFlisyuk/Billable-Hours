//
//  InputFieldsViewModel.swift
//  Billable Hours
//
//  Created by Елизавета Флисюк on 09.01.26.
//

import Foundation
import SwiftData

@Model
class HoursFieldsModel {
    var hoursStr: String
    var minutesStr: String
    var secondsStr: String
    var resultDigit: Double
    var resultString: String
    var date: Date = Date()

    init(hoursStr: String = "", minutesStr: String = "", secondsStr: String = "", resultDigit: Double = 0, resultString: String = "", date: Date = .now) {
        self.hoursStr = hoursStr
        self.minutesStr = minutesStr
        self.secondsStr = secondsStr
        self.resultDigit = resultDigit
        self.resultString = resultString
        self.date = date
    }

    func submit() {
        let hours = calculateHours(hoursStr, minutesStr, secondsStr)
        resultDigit = hours.rounded(to: 3)
        resultString = formatted(hoursStr, minutesStr, secondsStr)
    }

    var isValid: Bool {
        isValidMinutes(minutesStr) && isValidSeconds(secondsStr) && isValidHours(hoursStr)
    }


    func isValidMinutes(_ minutes: String) -> Bool {
        guard let minutesInt = Int(minutes) else {
            return false
        }
        return (0...59).contains(minutesInt)
    }

    func isValidSeconds(_ seconds: String) -> Bool {
        guard let secondsInt = Int(seconds) else {
            return false
        }
        return (0...59).contains(secondsInt)
    }

    func isValidHours(_ hours: String) -> Bool {
        guard let hoursInt = Int(hours) else {
            return false
        }
        return (0...999).contains(hoursInt)
    }

    func hoursInt(_ string: String) -> Int {
        Int(string) ?? 0
    }

    func secondsInt(_ string: String) -> Int {
        Int(string) ?? 0
    }

    func minutesInt (_ string: String) -> Int {
        Int(string) ?? 0
    }

    func formatted(_ hours: String, _ minutes: String, _ seconds: String) -> String {
        var formattedStr: [String] = []
        formattedStr.append(hours)
        formattedStr.append(":")
        formattedStr.append(minutes)
        formattedStr.append(":")
        formattedStr.append(seconds)
        let stringResult = String(formattedStr.joined())

        return stringResult
    }

    func calculateHours (_ hours: String, _ minutes: String, _ seconds: String) -> Double {
        let hours = hoursInt(hours)
        let minutes = minutesInt(minutes)
        let seconds = secondsInt(seconds)
        return Double(hours) + Double(minutes) / 60 + Double(seconds) / 3600
    }
}






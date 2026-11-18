//
//  InputHoursFields.swift
//  Billable Hours
//
//  Created by Елизавета Флисюк on 09.01.26.
//

import SwiftUI
import SwiftData

struct InputHoursFields: View {
    @Bindable var vmh: HoursFieldsModel

    var body: some View {
        VStack (spacing: 0) {
            Section {
                HStack(spacing: 10) {

                    TextField("00", text: $vmh.hoursStr)
                        .numberFieldBaseStyle()
                        .fieldBorder(state(vmh.hoursStr, isValid: vmh.isValidHours(vmh.hoursStr)))
                    Text(":")
                        .foregroundStyle(.secondary)

                    TextField("00", text: $vmh.minutesStr)
                        .numberFieldBaseStyle()
                        .fieldBorder(state(vmh.minutesStr, isValid: vmh.isValidMinutes(vmh.minutesStr)))
                    Text(":")
                        .foregroundStyle(.secondary)

                    TextField("00", text: $vmh.secondsStr)
                        .numberFieldBaseStyle()
                        .fieldBorder(state(vmh.secondsStr, isValid: vmh.isValidSeconds(vmh.secondsStr)))

                    Spacer()

                    CalcButton(vmh: vmh)
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            } header: {
                HStack {
                    Text("Duration (hh:mm:ss)")
                        .foregroundStyle(.secondary)
                        .fontWeight(.semibold)
                        .padding(.leading, 36)
                        .padding(.vertical, 12)
                    Spacer()
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
        .background(Color(.systemGroupedBackground))
    }

    private func state(_ text: String, isValid: Bool) -> FieldsState {
        if text.isEmpty {
            return .start
        }
        else if isValid {
            return .moderate
        }
        return .error
    }
}


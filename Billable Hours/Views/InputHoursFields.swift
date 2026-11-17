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
                    TextField ("00", text: $vmh.hoursStr)
                        .numberFieldBaseStyle()
                        .foregroundStyle(vmh.isValidHours(vmh.hoursStr) ? .blue : .red)

                    Text(":")
                        .foregroundStyle(.secondary)

                    TextField ("00", text: $vmh.minutesStr)
                        .numberFieldBaseStyle()
                        .foregroundStyle(vmh.isValidMinutes(vmh.minutesStr) ? .blue : .red)

                    Text(":")
                        .foregroundStyle(.secondary)

                    TextField ("00", text: $vmh.secondsStr)
                        .numberFieldBaseStyle()
                        .foregroundStyle(vmh.isValidSeconds(vmh.secondsStr) ? .blue : .red)

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

        } .background(Color(.systemGroupedBackground))
    }
}


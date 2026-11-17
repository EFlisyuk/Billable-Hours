//
//  CalcHoursFields.swift
//  Billable Hours
//
//  Created by Елизавета Флисюк on 09.01.26.
//

import SwiftUI
import SwiftData

struct CalcHoursFields: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \HoursFieldsModel.date) var calculations: [HoursFieldsModel]
    @State private var showCopied = false
    @State var selectedMode: ViewMode = .hours
    @State private var hourlyRate: String = ""
    
    var body: some View {
        VStack {
            if calculations.isEmpty {
                ContentUnavailableView("No Calculations", systemImage: "numbers.rectangle")
                    .opacity(0.2)
                    .background(Color(.systemGroupedBackground))
            } else {
                VStack {
                    Picker("Mode", selection: $selectedMode) {
                        Text("Hours").tag(ViewMode.hours)
                        Text("Earnings").tag(ViewMode.earnings)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    .padding(.top, 16)
                    
                    if selectedMode == .hours {
                        
                        calculatedHoursList
                        
                    } else {
                        
                        calculatedEarningsList
                        
                    }
                }
                .background(Color(.systemGroupedBackground))
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        
        ButtonsListControl(hourlyRate: hourlyRate)
        
    }
    
    private var calculatedHoursList: some View {
        List {
            HStack {
                HStack {
                    Image(systemName: "sum")
                    Text("\(Totals.sumDurations(calculations))")
                }
                Spacer()
                
                let totalHours = Totals.sumHours(calculations)
                Text("\(totalHours, specifier: "%.3f")")
                CopyButton(result: totalHours, showCopied: $showCopied)
            }
            .foregroundStyle(.primary)
            
            ForEach(calculations) { result in
                HStack {
                    HStack {
                        Image(systemName: "clock")
                        Text("\(result.resultString)")
                    }
                    .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "h.circle")
                        Text("\(result.resultDigit, specifier: "%.3f")")
                        CopyButton(result: result.resultDigit, showCopied: $showCopied)
                    }
                    .foregroundStyle(.green)
                }
            }
            .onDelete(perform: deleteCalc(indexes:))
        }
        .overlay(alignment: .top) {
            if showCopied {
                CopiedBadgeView()
            }
        }
        .animation(.easeInOut, value: showCopied)
    }
    
    private var calculatedEarningsList: some View {
        List {
            HStack {
                Text("Hourly Rate")
                TextField("0.0", text: $hourlyRate)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 16)
                    .foregroundStyle(.blue)
#if os(iOS)
                    .keyboardType(UIDevice.current.userInterfaceIdiom == .pad ? .numbersAndPunctuation : .numberPad)
#endif
                HStack {
                    let totalEarnings = Totals.sumEarnings(hourlyRate, calculations)
                    Image(systemName: "sum")
                    Text("\(totalEarnings, specifier: "%.2f")")
                }
            }
            
            ForEach(calculations) { result in
                HStack {
                    HStack {
                        Image(systemName: "h.circle")
                        Text("\(result.resultDigit, specifier: "%.3f")")
                    }
                    .foregroundStyle(.green)
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "dollarsign.circle")
                        if let rate = Totals.rate(hourlyRate) {
                            Text("\(result.resultDigit * rate, specifier: "%.2f")")
                        } else {
                            Text("")
                        }
                    }
                }
            }
            .onDelete(perform: deleteCalc(indexes:))
        }
    }
    
    func deleteCalc(indexes: IndexSet) {
        for index in indexes {
            let calcToDelete = calculations[index]
            context.delete(calcToDelete)
        }
    }
}

#Preview {
    CalcHoursFields()
        .modelContainer(for: [HoursFieldsModel.self, HoursList.self], inMemory: true)
}

#Preview("Test Data") {
    CalcHoursFields()
        .modelContainer(previewContainer())
}


//
//  NewListView.swift
//  Billable Hours
//
//  Created by Елизавета Флисюк on 06.05.26.
//

import SwiftUI
import SwiftData

struct NewListView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Query(sort: \HoursFieldsModel.date) var calculations: [HoursFieldsModel]
    @State private var newHoursListName: String = ""
    var hourlyRate: String

    var body: some View {
        let sumDurations = Totals.sumDurations(calculations)
        let sumHours = Totals.sumHours(calculations)

        Form {
            TextField("New List Name", text: $newHoursListName)
                .textSelectionAffinity(.upstream)

            Section("Hours List") {
                HStack {
                    Text("Hourly Rate: ")
                    Spacer()
                    Text("\(hourlyRate)")
                }

                HStack {
                    Image(systemName: "clock")
                    Text("\(sumDurations)")
                    Spacer()

                    Image(systemName: "h.circle")
                    Text("\(sumHours, specifier: "%.3f")")
                }

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
                        }
                        .foregroundStyle(.green)
                    }
                }
            }
        }
        .navigationTitle("Save list")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    // create a snapshot of each calculation
                    let simpleItems = calculations.map {
                        ArchivedCalculation(
                            resultDigit: $0.resultDigit,
                            resultString: $0.resultString,
                            date: $0.date, id: UUID()
                        )
                    }

                    // create archive list with a structure instead link on class
                    let finalName = newHoursListName.isEmpty ? defaultListName : newHoursListName
                    let newList = HoursList(name: finalName, sumHours: sumHours, sumDurations: sumDurations, hourlyRate: hourlyRate, listResults: simpleItems, date: .now)
                    context.insert(newList)

                    // delete originals from the working queue
                    for original in calculations {
                        context.delete(original)
                    }

                    do {
                        try context.save()
                        dismiss()
                    } catch {
                        print("Save error: \(error)")
                    }
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }

    private var defaultListName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: .now)
    }
}

#Preview {
    @Previewable @State var hourlyRate: String = "0.0"
    NewListView(hourlyRate: hourlyRate)
        .modelContainer(previewContainer())

}

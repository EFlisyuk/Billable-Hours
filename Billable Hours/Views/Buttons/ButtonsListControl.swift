//
//  ButtonsListControl.swift
//  Billable Hours
//
//  Created by Елизавета Флисюк on 16.11.2026.
//

import SwiftUI
import SwiftData

struct ButtonsListControl: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \HoursFieldsModel.date) var calculations: [HoursFieldsModel]
    @State private var showModal = false

    var hourlyRate: String

    var body: some View {
        HStack (spacing: 16) {
            Button(role: .destructive) {
                for row in calculations {
                    context.delete(row)
                }
                do {
                    try context.save()
                }
                catch {
                    print("Clean list error: \(error)")
                }
            } label: {
                Label("Clean list", systemImage: "trash")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .buttonsListControlStyle(isEmpty: calculations.isEmpty , color: .red)

            Button {
                showModal = true
            } label: {
                Label("Save list", systemImage: "plus.square")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .buttonsListControlStyle(isEmpty: calculations.isEmpty , color: .green)
        }
        .padding()
        .padding(.bottom, 16)
        .background(Color(.systemGroupedBackground))

        .sheet(isPresented: $showModal) {
            NavigationStack {
                NewListView(hourlyRate: hourlyRate)
            }
        }
    }
}

#Preview {
    ButtonsListControl(hourlyRate: "1400")
        .modelContainer(previewContainer())
}

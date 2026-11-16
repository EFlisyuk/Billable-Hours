//
//  Billable_HoursApp.swift
//  Billable Hours
//
//  Created by Елизавета Флисюк on 16.09.25.
//

import SwiftUI
import SwiftData

@main
struct Billable_HoursApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [HoursFieldsModel.self, HoursList.self])
        }
    }
}

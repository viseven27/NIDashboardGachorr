//
//  NIDashboardGachorrApp.swift
//  NIDashboardGachorr
//
//  Created by Alvin Justine on 22/07/25.
//

import SwiftUI

@main
struct NIDashboardGachorrApp: App {
    var body: some Scene{
        WindowGroup{
            ContentView()
        }
        .modelContainer(for: VehicleData.self)
    }
}

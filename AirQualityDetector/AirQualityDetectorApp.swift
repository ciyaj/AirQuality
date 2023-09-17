//
//  AirQualityDetectorApp.swift
//  AirQualityDetector
//
//  Created by Ciya Joseph on 9/14/23.
//

import SwiftUI

@main
struct AirQualityDetectorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

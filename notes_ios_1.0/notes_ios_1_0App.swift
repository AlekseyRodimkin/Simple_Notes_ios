//
//  notes_ios_1_0App.swift
//  notes_ios_1.0
//
//  Created by Алексей Родимкин on 21.10.2025.
//

import SwiftUI
import SwiftData

@main
struct notes_ios_1_0App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Note.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

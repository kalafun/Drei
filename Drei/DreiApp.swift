//
//  DreiApp.swift
//  Drei
//
//  Created by Tomas Bobko on 23.01.25.
//

import SwiftUI
import SwiftData

@main
struct DreiApp: App {

    @StateObject var contentViewModel = ContentView.ViewModel()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
            ContentView(viewModel: contentViewModel)
        }
        .modelContainer(sharedModelContainer)
    }
}

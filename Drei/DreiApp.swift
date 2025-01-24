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

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: contentViewModel)
        }
    }
}

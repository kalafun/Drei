//
//  AppViewModel.swift
//  Drei
//
//  Created by Tomas Bobko on 24.01.25.
//

import Foundation

@MainActor
class AppViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var showsError = false
    var localizedError: WeatherError?

    func handleAPIError(_ error: Error) {
        if let weatherError = error as? WeatherError {
            self.localizedError = weatherError
            self.showsError = true
        }
    }
}

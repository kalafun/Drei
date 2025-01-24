//
//  ContentViewModel.swift
//  Drei
//
//  Created by Tomas Bobko on 24.01.25.
//

import Foundation

extension ContentView {

    @MainActor
    class ViewModel: AppViewModel {

        private let searchWeatherService: SearchWeatherServiceProtocol
        @Published var searchName = ""

        init(searchWeatherService: SearchWeatherServiceProtocol = SearchWeatherService()) {
            self.searchWeatherService = searchWeatherService
        }

        func getCity() async {
            isLoading = true

            do {
                let response = try await searchWeatherService.searchCity(name: searchName)
            } catch {
                print(error)
            }

            isLoading = false
        }
    }
}

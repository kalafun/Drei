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
        @Published var response: SearchCityResponse?

        var cityName: String? {
            response?.name
        }

        var temperature: String? {
            if let temp = response?.main.temp {
                return "\(temp) °C"
            }

            return nil
        }

        init(searchWeatherService: SearchWeatherServiceProtocol = SearchWeatherService()) {
            self.searchWeatherService = searchWeatherService
        }

        func getCity() async {
            isLoading = true

            do {
                self.response = try await searchWeatherService.searchCity(name: searchName)
            } catch {
                print(error)
            }

            isLoading = false
        }
    }
}

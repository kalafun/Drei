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
        @Published var iconURL: URL?

        var cityName: String? {
            response?.name
        }

        var temperature: String? {
            if let temp = response?.main.temp {
                return "\(temp) °C"
            }

            return nil
        }

        var windSpeed: String? {
            if let windSpeed = response?.wind?.speed {
                return "\(windSpeed) m/s"
            }
            
            return nil
        }

        var rainPrecipation: String? {
            if let precipation = response?.rain?.oneHour {
                return "\(precipation) mm/h"
            }

            return nil
        }

        var snowPrecipation: String? {
            if let precipation = response?.snow?.oneHour {
                return "\(precipation) mm/h"
            }

            return nil
        }

        var weatherDescription: String? {
            if let weatherDescription = response?.weather.first?.description {
                return weatherDescription.capitalized
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
                searchName = ""

                if let icon = response?.weather.first?.icon {
                    iconURL = searchWeatherService.getWeatherIconURL(icon: icon)
                }
            } catch {
                print(error)
                handleAPIError(error)
            }

            isLoading = false
        }
    }
}

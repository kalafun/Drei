//
//  SearchWeatherServiceFailingMocked.swift
//  Drei
//
//  Created by Tomas Bobko on 24.01.25.
//

import Foundation

class SearchWeatherServiceFailingMocked: Service, SearchWeatherServiceProtocol {
    func searchCity(name: String) async throws -> SearchCityResponse {
        throw WeatherError.cityNotFound
    }

    func getWeatherIconURL(icon: String) -> URL? {
        nil
    }
}

//
//  SearchWeatherService.swift
//  Drei
//
//  Created by Tomas Bobko on 23.01.25.
//

import Foundation
import Alamofire

protocol SearchWeatherServiceProtocol: Service {
    func searchCity(name: String) async throws -> SearchCityResponse
    func getWeatherIconURL(icon: String) -> URL?
}

class SearchWeatherService: Service, SearchWeatherServiceProtocol {

    var cacher = Cacher()

    func searchCity(name: String) async throws -> SearchCityResponse {

        if !NetworkMonitor.shared.isConnected {
            if let cachedResponse = cacher.getCachedResponse() {
                return cachedResponse
            } else {
                throw WeatherError.noInternetAndNoCachedData
            }
        }

        let response = try await AF.request(
            baseURL.appending(path: "weather"),
            method: .get,
            parameters: SearchCityRequest(q: name, appid: Config.API.OWAPIKey)
        )
        .responseData(decodingType: SearchCityResponse.self)

        cacher.cacheResponse(response)

        return response
    }

    func getWeatherIconURL(icon: String) -> URL? {
        Config.API.weatherURL.appendingPathComponent("\(icon)@2x.png")
    }
}

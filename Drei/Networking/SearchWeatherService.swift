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
}

class SearchWeatherService: Service, SearchWeatherServiceProtocol {

    func searchCity(name: String) async throws -> SearchCityResponse {
        try await AF.request(
            baseURL.appending(path: "weather"),
            method: .get,
            parameters: SearchCityRequest(q: name, appid: Config.API.OWAPIKey)
        )
        .responseData(decodingType: SearchCityResponse.self)
    }
}

struct SearchCityRequest: Encodable {
    let q: String
    let appid: String
    let units: String = "metric"
}

struct Weather: Decodable {
    let main: String
    let description: String
    let icon: String
}

struct Wind: Decodable {
    let speed: Float
    let gust: Float
}

struct MainWeather: Decodable {
    let temp: Float
    let feelsLike: Float
    let pressure: Int
    let humidity: Int
    let tempMin: Float
    let tempMax: Float

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct SearchCityResponse: Decodable {
    let weather: [Weather]
    let main: MainWeather
    let wind: Wind
    let name: String
}

extension Alamofire.DataRequest {
    func responseData<D: Decodable>(decodingType: D.Type) async throws -> D {
        return try await withCheckedThrowingContinuation { continuation in
            self.responseData { response in
                print(response.request?.urlRequest)

                if let data = response.data {
                    print(NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "")
                    do {
                        let decodedObject = try JSONDecoder().decode(D.self, from: data)
                        continuation.resume(returning: decodedObject)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                } else {
                    print("NO DATA")
                }
            }
        }
    }
}

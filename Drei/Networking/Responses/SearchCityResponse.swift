//
//  SearchCityResponse.swift
//  Drei
//
//  Created by Tomas Bobko on 24.01.25.
//

import Foundation

struct Weather: Codable {
    let main: String
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Float?
    let gust: Float?
}

struct MainWeather: Codable {
    let temp: Float

    enum CodingKeys: String, CodingKey {
        case temp
    }
}

struct Precipation: Codable {
    let oneHour: Float

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}

struct SearchCityResponse: Codable {
    let weather: [Weather]
    let main: MainWeather
    let wind: Wind?
    let name: String
    let rain: Precipation?
    let snow: Precipation?
}

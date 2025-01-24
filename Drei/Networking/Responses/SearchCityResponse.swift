//
//  SearchCityResponse.swift
//  Drei
//
//  Created by Tomas Bobko on 24.01.25.
//

import Foundation

struct Weather: Decodable {
    let main: String
    let description: String
    let icon: String
}

struct Wind: Decodable {
    let speed: Float?
    let gust: Float?
}

struct MainWeather: Decodable {
    let temp: Float

    enum CodingKeys: String, CodingKey {
        case temp
    }
}

struct Precipation: Decodable {
    let oneHour: Float

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}

struct SearchCityResponse: Decodable {
    let weather: [Weather]
    let main: MainWeather
    let wind: Wind?
    let name: String
    let rain: Precipation?
    let snow: Precipation?
}

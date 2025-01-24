//
//  SearchWeatherServiceMocked.swift
//  Drei
//
//  Created by Tomas Bobko on 24.01.25.
//

import Foundation

class SearchWeatherServiceMocked: Service, SearchWeatherServiceProtocol {
    func searchCity(name: String) async throws -> SearchCityResponse {
        SearchCityResponse(
            weather: [
                Weather(
                    main: "Clouds",
                    description: "overcast clouds",
                    icon: "04n"
                )
            ],
            main: MainWeather(
                temp: 3.52
            ),
            wind: Wind(
                speed: 0.45,
                gust: 2.24
            ),
            name: "Vienna",
            rain: Precipation(oneHour: 0.1),
            snow: Precipation(oneHour: 0.14)
        )
    }

    func getWeatherIconURL(icon: String) -> URL? {
        URL(string: "https://openweathermap.org/img/wn/10d@2x.png")
    }
}

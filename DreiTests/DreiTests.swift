//
//  DreiTests.swift
//  DreiTests
//
//  Created by Tomas Bobko on 23.01.25.
//

import XCTest
@testable import Drei

final class DreiTests: XCTestCase {

    private let searchWeatherServiceMocked = SearchWeatherServiceMocked()
    private let searchWeatherServiceFailingMocked = SearchWeatherServiceFailingMocked()
    private let cityName = "Vienna"

    func testTemperatureNotNil() async throws {
        let response = try await searchWeatherServiceMocked.searchCity(name: cityName)
        XCTAssertNotNil(response.main.temp)
    }

    func testWeatherIconNotNil() async throws {
        let response = try await searchWeatherServiceMocked.searchCity(name: cityName)
        XCTAssertNotNil(response.weather.first?.icon)
    }

    func testCityNameIsVienna() async throws {
        let response = try await searchWeatherServiceMocked.searchCity(name: cityName)
        XCTAssertTrue(response.name == "Vienna")
    }

    func testCityNameIsNotVienna() async throws {
        let response = try await searchWeatherServiceMocked.searchCity(name: "Graz")
        XCTAssertFalse(response.name == "Vienna")
    }

    func testCityNotFound() async {
        do {
            _ = try await searchWeatherServiceFailingMocked.searchCity(name: cityName)
        } catch {
            if let error = error as? WeatherError {
                switch error {
                    case .cityNotFound:
                        XCTAssertTrue(true)
                    default:
                        XCTFail()
                }
            }
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

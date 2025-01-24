//
//  WeatherError.swift
//  Drei
//
//  Created by Tomas Bobko on 24.01.25.
//

import Foundation

enum WeatherError: LocalizedError {
    case cityNotFound
    case noInternetAndNoCachedData
    case other(localizedErrorString: String)

    var errorDescription: String? {
        switch self {
            case .cityNotFound:
                return "City not found"
            case .noInternetAndNoCachedData:
                return "No internet and no cached data"
            case let .other(localizedErrorString):
                return localizedErrorString
        }
    }
}

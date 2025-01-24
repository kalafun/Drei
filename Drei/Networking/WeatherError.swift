//
//  WeatherError.swift
//  Drei
//
//  Created by Tomas Bobko on 24.01.25.
//

import Foundation

enum WeatherError: LocalizedError {
    case cityNotFound

    var errorDescription: String? {
        switch self {
            case .cityNotFound:
                return "City not found"
        }
    }
}

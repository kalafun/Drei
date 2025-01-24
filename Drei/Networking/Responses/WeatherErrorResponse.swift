//
//  WeatherErrorResponse.swift
//  Drei
//
//  Created by Tomas Bobko on 24.01.25.
//

import Foundation

struct WeatherErrorResponse: Decodable {
    let cod: String?
    let message: String?
}

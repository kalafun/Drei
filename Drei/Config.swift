//
//  Config.swift
//  Drei
//
//  Created by Tomas Bobko on 23.01.25.
//

import Foundation

struct Config {

    struct API {
        static let OWAPIKey = "45fd7361e65d65a40cfbb6e9c983032e"
        static let baseURL = URL(string: "https://api.openweathermap.org/data/2.5/")!
        static let weatherURL = URL(string: "https://openweathermap.org/img/wn/")!
    }
}

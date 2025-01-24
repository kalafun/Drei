//
//  SearchCityRequest.swift
//  Drei
//
//  Created by Tomas Bobko on 24.01.25.
//

import Foundation

struct SearchCityRequest: Encodable {
    let q: String
    let appid: String
    let units: String = "metric"
}

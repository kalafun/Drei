//
//  Cacher.swift
//  Drei
//
//  Created by Tomas Bobko on 24.01.25.
//

import Foundation

class Cacher {
    private let cacheKey = "LastSearchCityResponse"

    func cacheResponse(_ response: SearchCityResponse) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(response) {
            UserDefaults.standard.set(data, forKey: cacheKey)
        }
    }

    func getCachedResponse() -> SearchCityResponse? {
        guard let data = UserDefaults.standard.data(forKey: cacheKey) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(SearchCityResponse.self, from: data)
    }
}

//
//  Cacher.swift
//  Drei
//
//  Created by Tomas Bobko on 24.01.25.
//

import Foundation

class Cacher<C: Codable> {

    private var cacheKey: String {
        "\(C.self)"
    }

    func cacheResponse(_ response: C) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(response) {
            UserDefaults.standard.set(data, forKey: cacheKey)
        }
    }

    func getCachedResponse() -> C? {
        guard let data = UserDefaults.standard.data(forKey: cacheKey) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(C.self, from: data)
    }
}

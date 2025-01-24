//
//  Alamofire+Extensions.swift
//  Drei
//
//  Created by Tomas Bobko on 24.01.25.
//

import Foundation
import Alamofire

extension Alamofire.DataRequest {
    func responseData<D: Decodable>(decodingType: D.Type) async throws -> D {
        return try await withCheckedThrowingContinuation { continuation in
            self.responseData { response in
                print(response.request?.urlRequest ?? "NO REQUEST DATA")

                if let data = response.data {
                    print(NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "")
                    do {

                        // check for error response
                        if let errorObject = try? JSONDecoder().decode(WeatherErrorResponse.self, from: data) {
                            if let cod = errorObject.cod {
                                if cod == "404" {
                                    continuation.resume(throwing: WeatherError.cityNotFound)
                                    return
                                }
                            }
                        }

                        let decodedObject = try JSONDecoder().decode(D.self, from: data)
                        continuation.resume(returning: decodedObject)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                } else {
                    print("NO DATA")
                }
            }
        }
    }
}

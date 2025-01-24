//
//  NetworkMonitor.swift
//  Drei
//
//  Created by Tomas Bobko on 24.01.25.
//

import Foundation
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    private(set) var isConnected: Bool = false

    private init() {
        print("Network monitor Init")
        monitor.pathUpdateHandler = { path in
            print("NETWORK STATUS: \(path.status)")
            self.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}

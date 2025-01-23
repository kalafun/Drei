//
//  Item.swift
//  Drei
//
//  Created by Tomas Bobko on 23.01.25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

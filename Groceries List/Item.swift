//
//  Item.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/21/25.
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

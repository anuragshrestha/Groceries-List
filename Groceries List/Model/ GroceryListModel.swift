//
//  GroceryModel.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 3/15/25.
//

import Foundation

struct GroceryListModel:Identifiable, Codable {
    var id: String { return listId }
    let userId: String
    let listId: String
    let groceries: GroceryItem
}

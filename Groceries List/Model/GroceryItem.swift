//
//  GroceryItem.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 3/9/25.
//

import Foundation

struct GroceryItem: Identifiable,Codable{
    var id: String { return listId ?? UUID().uuidString}
    let groceryName: String
    let quantity: String
    let dueDate: String
    let listId: String?
}

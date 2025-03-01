//
//  AddGroceryViewModel.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/28/25.
//

import Foundation

class AddGroceryViewModel: ObservableObject {
    
    @Published var groceryItem:String = ""
    @Published var quantity:String = ""
    @Published var currentTime:Date = Date()
    @Published var isDatePickerPresented:Bool = false
}

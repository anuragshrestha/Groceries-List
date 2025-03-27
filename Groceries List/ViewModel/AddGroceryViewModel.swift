//
//  AddGroceryViewModel.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/28/25.
//

import Foundation

class AddGroceryViewModel: ObservableObject {
    
    @Published var groceryItem: String = ""
    @Published var quantity: String = ""
    @Published var currentTime: Date = Date()
    @Published var isDatePickerPresented: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let groceryService = GroceryService()
    
    /// Function to add a grocery item
    func addGrocery() {
        // Validate user input
        guard !groceryItem.isEmpty, !quantity.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }
        
        // Format date to YYYY-MM-DD
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: currentTime)
        
        let item = GroceryItem(groceryName: groceryItem, quantity: quantity, dueDate: formattedDate, listId: nil)
        
        isLoading = true
        
        // Call API to add grocery
        groceryService.addGrocery(item: item) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let message):
                    print("Success: \(message)")
                    self?.resetFields()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    /// Reset form fields after successful submission
    private func resetFields() {
        groceryItem = ""
        quantity = ""
        currentTime = Date()
    }
}

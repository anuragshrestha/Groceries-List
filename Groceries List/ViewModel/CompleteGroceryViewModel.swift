//
//  CompleteGroceryViewModel.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 3/29/25.
//

import Foundation

class CompleteGroceryViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var isComplete: Bool = false
    
    private var completeService = CompleteService()
    
    func completeGrocery(listId: String, groceryName: String, quantity: String, dueDate: Date){
        
        guard !listId.isEmpty || !groceryName.isEmpty || !quantity.isEmpty else {
            self.errorMessage = "Please fill all the fields"
            return
        }
        
        let dateFromatter = DateFormatter()
        dateFromatter.dateFormat = "yyyy-MM-dd"
        let formatDate = dateFromatter.string(from: dueDate)
        
        let item = GroceryItem(groceryName: groceryName, quantity: quantity, dueDate: formatDate, listId: listId)
        
        isLoading = true
        
        completeService.completeService(item: item) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let message):
                    print("Successfully stored in History table \(message)")
                    self?.isComplete = true
                case .failure(let error):
                    print("Failed to store in history table \(error)")
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

//
//  UpdateGroceryViewModel.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 3/26/25.
//

import Foundation

class UpdateGroceryViewModel: ObservableObject {
    
  
    @Published var isLoading:Bool = false
    @Published var errorMessage: String?
    @Published var didUpdateSuccessfully:Bool = false
    
    
    private let updateService = UpdateService()
    
    /**
     - guards the input field
     - change the due date to string format
     - change the parameters to GroceryItem
     - call the uodateGrocery service and pass the item, list  id
     - check if it's a success then move back to the homescreen
     - if failure then show the failure text
     */
    
    
    //updates the grocery
    func updateGrocery(listId: String, groceryName: String, quantity:String, dueDate: Date) {
        
        //checks if any any of the input field is empty
        guard !groceryName.isEmpty, !quantity.isEmpty  else {
            self.errorMessage = "Fill all the input field"
            return
        }
        
        
        //formats the date in "yyyy-MM-dd" format and change it to string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formatDate = dateFormatter.string(from: dueDate)
        
        let item = GroceryItem(groceryName: groceryName, quantity: quantity, dueDate: formatDate, listId: listId)
        print("item in update View model: ", item)
        
        
        isLoading = true
        
        //calls the update grocery Api service
        updateService.updateGrocery(item: item) { [weak self] result in
            DispatchQueue.main.async{
                self?.isLoading = false
                switch result{
                case .success(let message):
                    print("Success: \(message)")
                    self?.didUpdateSuccessfully = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    
                }
            }
        }
        
    }
    
}

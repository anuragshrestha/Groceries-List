//
//  DeleteViewModel.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 3/28/25.
//

import Foundation

class DeleteViewModel: ObservableObject{
    
    @Published var isLoading:Bool = false
    @Published var errorMessage:String?
    @Published var isDeleted:Bool = false
    
    private var deleteService  = DeleteService()
    
    func deleteGrocery(listId: String) {
        
      
        if listId.isEmpty{
            self.errorMessage = "List Id is empty!"
            return
        }
        
        self.isLoading = true
        
        deleteService.deleteGrocery(listId: listId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result{
                case .success(let message):
                    print("Sucess \(message)")
                    self?.isDeleted = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

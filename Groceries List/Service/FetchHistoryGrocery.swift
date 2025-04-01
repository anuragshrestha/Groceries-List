//
//  FetchHistoryGrocery.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 3/29/25.
//

import Foundation
import Combine

@MainActor
class FetchHistoryGrocery: ObservableObject {
    
    let baseUrl = "http://localhost:3000/grocery/history"
    @Published var groceryList: [GroceryItem]  = []
    @Published var errorMessage: String?
    
    func fetchGroceries() async {
        
        guard let url = URL(string: baseUrl) else {
            self.errorMessage = "Invalid Url"
            return
        }
        
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else {
            self.errorMessage = "Invalid token"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else{
                self.errorMessage = "Not a url response"
                return
            }
            
        
            print("API Response JSON: \(String(data: data, encoding: .utf8) ?? "No data")")
            
            if httpResponse.statusCode == 200 {
                let decodeResponse = try JSONDecoder().decode(GroceryResponses.self, from: data)
                    self.groceryList = decodeResponse.groceryList
                    self.errorMessage = nil
            }else{
                self.errorMessage = "HTTP Error: \(httpResponse.statusCode)"
            }
        }catch{
            self.errorMessage = "\(error)"
        }
    }
}

struct GroceryResponses: Codable{
    let message: String
    let groceryList: [GroceryItem]
}

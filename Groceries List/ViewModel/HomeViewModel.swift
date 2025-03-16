//
//  HomeViewModel.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/27/25.
//

import Foundation


@MainActor
class HomeViewModel: ObservableObject{
    
    /**
     - create the base url
     - create the url object
     - extract the token
     - craete the url request
     - add the httpMethod, set  application type,  set token
     - make the api call URLSession  inside do catch
     */
    
    @Published var selectedTab: Int = 0
    @Published var username: String = ""
    @Published var name:String = ""
    @Published var groceryLists: [GroceryListModel] = []
    @Published var errorMessage: String? = nil
    private let baseUrl = "http://localhost:3000/grocery/get"
    
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
                let decodeResponse = try JSONDecoder().decode(GroceryResponse.self, from: data)
                    self.groceryLists = decodeResponse.groceryList
                    self.errorMessage = nil
                
            }
        }catch{
            self.errorMessage = "\(error)"
        }
    }
}

struct GroceryResponse: Codable{
    let message: String
    let groceryList: [GroceryListModel]
}

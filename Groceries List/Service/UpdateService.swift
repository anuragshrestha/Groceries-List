//
//  UpdateService.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 3/26/25.
//

import Foundation

/**
 - write the base url
 - inside the function:
 - guard the url
 - retrive the token
 - create a HTTP request and add the values
 - encode the item into json
 - make Api call
 */

class UpdateService{
    
    let baseUrl = "http://localhost:3000/grocery/update"
    
    func updateGrocery(item: GroceryItem, completion: @escaping (Result<String, Error>) -> Void){
        
        
        //checks if it's a valid url
        guard let url =  URL(string:baseUrl) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        //retrives the token from User Defaults
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else {
            completion(.failure(NSError(domain: "AUTH", code: 401, userInfo: ["message": "User not authenticated"])))
            return
        }
        
        //creates a http request
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "PUT"
        httpRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        httpRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        guard let listId = item.listId else {
            completion(.failure(NSError(domain: "Missing listId", code: 400, userInfo: nil)))
            return
        }
        
        //changing the GroceryItem into the structure that backend expects
        let payLoad: [String: Any] = [
            "listId": listId,
            "groceries": [
                "groceryName": item.groceryName,
                "quantity": item.quantity,
                "dueDate": item.dueDate
            ]
        ]
        
        // Encodes the data to json
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: payLoad, options: [])
            httpRequest.httpBody = jsonData
        }catch{
            completion(.failure(error))
            return
        }
        
        //Makes Api call
        URLSession.shared.dataTask(with: httpRequest) { data, response, error in if let error = error {
            completion(.failure(error))
            return
        }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid response", code: -2, userInfo: nil)))
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success("Grocery item updated successfully"))
            }else{
                completion(.failure(NSError(domain: "API Error", code: httpResponse.statusCode, userInfo: nil)))
            }
            
        }.resume()
    }
}

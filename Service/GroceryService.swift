//
//  GroceryService.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 3/9/25.
//

import Foundation

/**
 - write the base url
 - gaurd the url
 - guard the token
 - create http request
 - encode it to json
 - make api call
 */

class GroceryService{
    
    let baseUrl = "http://localhost:3000/grocery/add"
    
    func addGrocery(item: GroceryItem, completion: @escaping (Result<String, Error>) -> Void){
        
        //checks if it's a valid url
        guard let url = URL(string: baseUrl) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        //retrieves the token from UserDefault
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else {
            completion(.failure(NSError(domain: "AUTH", code: 401, userInfo: ["message": "User not authenticated"])))
            return
        }
        
        
        //creates a HTTP request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Cotent-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do{
            let jsonData = try JSONEncoder().encode(item)
            request.httpBody = jsonData
        }catch{
            completion(.failure(error))
            return
        }
        
        //Make Api call
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid response", code: -2, userInfo: nil)))
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success("Grocery item added successfully"))
            }else{
                completion(.failure(NSError(domain: "API Error", code: httpResponse.statusCode, userInfo: nil)))
            }
        }.resume()
    }
}

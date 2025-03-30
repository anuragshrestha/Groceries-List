//
//  CompleteService.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 3/29/25.
//

import Foundation


class CompleteService {
    
    let baseUrl = "http://localhost:3000/grocery/complete"

    func completeService(item: GroceryItem, completion: @escaping (Result<String, Error>) -> Void) {
      
       //creates a url object
        guard let url = URL(string:baseUrl) else {
            completion(.failure(NSError(domain: "Invalid Url", code: -1, userInfo: nil)))
            return
        }
        
        
        //extracts the token from User defaults
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else {
            completion(.failure(NSError(domain: "Authorization", code: 400, userInfo: ["message": "No token found"])))
            return
        }
        
        //creates a httpRequest
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "POST"
        httpRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        httpRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do{
            let jsonData = try JSONEncoder().encode(item)
            httpRequest.httpBody = jsonData
        }catch{
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: httpRequest) {  data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid response", code: -2, userInfo: nil)))
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success("Successfully saved Grocery item in new table"))
            }else{
                completion(.failure(NSError(domain: "API Error", code: httpResponse.statusCode, userInfo: nil)))
            }
        }.resume()
  }

}

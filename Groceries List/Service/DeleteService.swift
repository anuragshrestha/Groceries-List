//
//  DeleteService.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 3/28/25.
//

import Foundation

class DeleteService {
    
    let baseUrl = "http://localhost:3000/grocery/delete"
    
    /**
     - create the base url
     - create a delete func that takes the listd as a string
     - check if the base url is valid and create a url object
     - extract the token fron jwt
     - create the http body
     - check if there is a listId
     - start the delete request
     - check if the reponse is a http response
     - if status code is 200 then return success else handle the error
     */
    
    func deleteGrocery(listId: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        //checks if the list id is empty
        guard !listId.isEmpty else {
            completion(.failure(NSError(domain: "INVALID_INPUT", code: 400, userInfo: ["message":"listId is empty"])))
            return
        }
        
        //creates a URL object
        guard let url = URL(string: baseUrl) else {
            completion(.failure(NSError(domain: "Invalid url", code: -1, userInfo: nil)))
            return
        }
        
        
        //extracts the token
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else {
            completion(.failure(NSError(domain: "AUTH", code: 401, userInfo: ["message": "User not Authenticated"])))
            return
        }
        
        
        //creates http request
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "DELETE"
        httpRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        httpRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: httpRequest) { data, response , error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "HTTP Response", code: 2, userInfo: nil)))
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success("Grocery deleted successfully"))
                
            }else{
                completion(.failure(NSError(domain: "API Error", code: httpResponse.statusCode, userInfo: nil)))
            }
            
        }.resume()
        
    }
}

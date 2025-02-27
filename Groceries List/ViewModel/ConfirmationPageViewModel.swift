//
//  ConfirmationPageViewModel.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/26/25.
//

import Foundation
import Combine

class ConfirmationPageViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isConfirmed: Bool = false
    @Published var errorMessage:String? = nil
    @Published var confirmationCode:String = ""

    func confirmSignUp()  {
        
        //create a url object
       guard let url = URL(string: "http://localhost:3000/confirm") else {
            self.errorMessage = "Invalid URL"
           return
        }
        
        // creates http request and set the method for POST
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ConfirmationRequest(username: email, confirmationCode: confirmationCode)
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        }catch {
            self.errorMessage = error.localizedDescription
            return
        }
        
        
        /**
         * starts a newtrok request using URLSession.shared.dataTask
         * data: the response data from the server(if any)
         * response: contains status code, headers
         */
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            DispatchQueue.main.async {
                if let error = error{
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    self.errorMessage = "Invalid response from server"
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No data response from server"
                    return
                }
                
                print("data: ", data)
                
                if httpResponse.statusCode == 200 {
                    self.isConfirmed = true
                }else {
                    self.handleConfirmError(data: data)
                }
            }
        }.resume()
        
    }
    
    private func handleConfirmError(data: Data){
        do{
            let errorResponse = try JSONDecoder().decode(ConfirmationErrorResponse.self, from: data)
            switch errorResponse.name {
               case "UsernameExistsException":
                   self.errorMessage = "Account already exists with this email."
               case "InvalidPasswordException":
                   self.errorMessage = "Password does not meet security requirements."
               case "UserNotConfirmedException":
                   self.errorMessage = "Your account is not confirmed. Check your email."
               case "TooManyRequestsException":
                   self.errorMessage = "Too many signup attempts. Try again later."
               default:
                   self.errorMessage = errorResponse.message ?? "An unknown error occurred."
               }
           } catch {
               self.errorMessage = "Failed to decode error response."
           }
    }
}

struct ConfirmationRequest: Codable {
    let username: String
    let confirmationCode: String
}

struct ConfirmationErrorResponse: Codable {
    let name: String
    let message: String?
}


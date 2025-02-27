//
//  SignUpViewModel.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/25/25.
//
import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    @Published var userName: String = ""  // This will serve as the user's display name
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isShowPassword: Bool = false
    
    // State flags for navigation and error handling
    @Published var isSignedUp: Bool = false
    @Published var errorMessage: String? = nil
    
    func signUp() {
        
        //tries to create a url object
        guard let url = URL(string: "http://localhost:3000/signup") else {
            self.errorMessage = "Invalid URL."
            return
        }
        
        //create a HTTP request for POST request and the request body contains JSON data.
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = SignUpRequest(name: userName, username: email, password: password)
        
        //converts body from dictionary to JSON type.
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            self.errorMessage = error.localizedDescription
            return
        }
        
        /**
         •    Starts a network request using URLSession.shared.dataTask.
         •    data: The response data from the server (if any).
         •    response: The HTTP response (contains status codes, headers, etc.).
         •    error: Any network-level error (e.g., no internet connection).
         */
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    self.errorMessage = "Invalid response from server."
                    return
                }
        
                guard let data = data else{
                    self.errorMessage = "No response data recieved"
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    
                    // Trigger navigation to the confirmation page
                    self.isSignedUp = true
                } else {
                    self.handleServerError(data: data)
                  }
        
            }
        }.resume()
    }
    
    private func handleServerError(data: Data){
        do{
            let errorResponse = try JSONDecoder().decode(SignUpErrorResponse.self, from: data)
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


struct SignUpRequest: Codable {
    let name: String
    let username: String
    let password: String
}

struct SignUpErrorResponse: Codable {
    let name: String
    let message: String?
}

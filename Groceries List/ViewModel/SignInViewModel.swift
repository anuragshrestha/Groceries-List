//
//  SignInViewModel.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/27/25.
//

import Foundation



class SignInViewModel: ObservableObject{
    
    @Published var username:String = ""
    @Published var name:String = ""
    @Published var isSignIn: Bool = false
    @Published var password:String = ""
    @Published var errorMessage:String? = nil
    @Published var isShowPassword: Bool = false
    
    func signIn(){
        
        /**
         - create a url object
         - create a HTTP request and add the POST method
         - create a swift object of codable and send the body to the JSONEncoder
         - make a network request and check if there is a error then return the error
         - store the htto response
         - check for the data if no data then return the error
         - check if status code is 200, if so then navigate to the MainTabView
         - if not the call the error function
         */
        
        
        print("pressed signin button")
        //creates a URL Object
        guard let url = URL(string: "http://localhost:3000/signin") else {
            self.errorMessage = "Invalid url"
            return
        }
        
        //create a HTTP request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = signInRequest(username: username, password: password)
        
        //encode the body to JSON data format
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            self.errorMessage = error.localizedDescription
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error{
                    self.errorMessage = error.localizedDescription
                    return
                }
               
                guard let httpResponse = response as? HTTPURLResponse else{
                    self.errorMessage = error?.localizedDescription
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = error?.localizedDescription
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    self.isSignIn = true
                }else{
                    self.handleServerError(data: data)
                }
            }
        }.resume()
        
        
    }
    



    private func handleServerError(data:Data){
        
        do{
            let errorResponse = try JSONDecoder().decode(signInError.self, from: data)
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

struct signInRequest: Codable{
    let username: String
    let password:String
}

struct signInError: Codable{
    let name:String
    let message: String?
}


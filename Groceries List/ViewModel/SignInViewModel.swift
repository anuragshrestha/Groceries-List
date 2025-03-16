//
//  SignInViewModel.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/27/25.
//

import Foundation


@MainActor
class SignInViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isSignIn: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isShowPassword: Bool = false
    
    func signIn(homeViewModel: HomeViewModel) async {
        print("Pressed Sign In button")
        
        guard let url = URL(string: "http://localhost:3000/signin") else {
            self.errorMessage = "Invalid URL"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = signInRequest(username: username, password: password)

        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            self.errorMessage = error.localizedDescription
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let response = try JSONDecoder().decode(signInResponse.self, from: data)
                
                print("JWT Token received: \(response.token)")
                saveToken(response.token)
                
                    self.isSignIn = true
               
                await homeViewModel.fetchGroceries()
                print("Fetched groceries successfully")
                
            } else {
                self.handleServerError(data: data)
            }
        } catch {
            self.errorMessage = "Login error: \(error.localizedDescription)"
        }
    }

    private func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "jwtToken")
        UserDefaults.standard.synchronize()
    }
    
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: "jwtToken")
    }

    private func handleServerError(data: Data) {
        do {
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

struct signInRequest: Codable {
    let username: String
    let password: String
}

struct signInResponse: Codable {
    let token: String
}

struct signInError: Codable {
    let name: String
    let message: String?
}

//
//  SignUpView.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/21/25.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var signUPVM = SignUpViewModel()
    @State private var showAlert = false

    
    // A computed binding that checks if errorMessage exists
    private var showAlertBinding: Binding<Bool> {
        Binding<Bool>(
            get: { self.signUPVM.errorMessage != nil },
            set: { _ in self.signUPVM.errorMessage = nil }
        )
    }
    
    var body: some View {
        
            VStack{
                
                
                Text("Create a new Account")
                    .font(.customfont(.bold, fontSize: 26))
                    .foregroundColor(.red)
                    .padding(.top, .topInsets + 60)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)

                
                ScrollView{
                    
                    VStack{
                        LineTextField(text: $signUPVM.userName, title: "Full Name", placeholder: "Enter your full name")
                            .padding(.bottom, .screenWidth * 0.07)
                        
                        LineTextField(text: $signUPVM.email, title: "Email", placeholder:"Enter your email", keyboardType: .emailAddress)
                            .padding(.bottom, .screenWidth * 0.07)
                        
                        
                        SecureLineField(text: $signUPVM.password, title: "Password", placeholder: "Enter your password", isShowPassword: $signUPVM.isShowPassword)
                            .padding(.bottom, .screenWidth * 0.12)
                        
                        HStack{
                            Text("By continuing you agree to our ")
                                .font(.customfont(.semibold, fontSize: 15))
                                .foregroundColor(.primaryText) +
                            Text("terms of Service ")
                                .font(.customfont(.semibold, fontSize: 15))
                                .foregroundColor(.blue) +
                            Text("and ")
                                .font(.customfont(.semibold, fontSize: 15))
                                .foregroundColor(.primaryText) +
                            Text("Privacy Policy.")
                                .font(.customfont(.semibold, fontSize: 15))
                                .foregroundColor(.blue)
                        }
                        .padding(.bottom, .screenWidth * 0.07)
                        
                        
                        CustomButton(title: "Sign Up", didTap: {signUPVM.signUp()})
                            .padding(.bottom, .screenWidth * 0.02)
                        
                
                        NavigationLink(destination: SignInView()){
                            HStack{
                                Text("Already have an account?")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.primaryText)
                                
                                
                                Text("Sign In")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.blue)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, .bottomInsets)
                }
                .padding(.top, 10)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(
                gradient: Gradient(colors: [.gray, .white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
                .ignoresSafeArea()
            )
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .navigationDestination(isPresented: $signUPVM.isSignedUp) {
                ConfirmationPage(email: signUPVM.email)
            }
            .alert(isPresented: showAlertBinding)
        {
            Alert(
                title: Text("Error"),
                message: Text(signUPVM.errorMessage ?? "An unknown error occurred."),
                dismissButton: .default(Text("OK"))
            )
        }
        
    }
}



#Preview {
    
    NavigationStack{
        SignUpView()
    }
}

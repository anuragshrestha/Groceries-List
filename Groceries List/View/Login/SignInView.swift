//
//  SignInView.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/21/25.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject var loginVM = SignInViewModel()
    @StateObject var homeViewModel = HomeViewModel()
    
    // A computed binding that checks if errorMessage exists
    private var showAlertBinding: Binding<Bool> {
        Binding<Bool>(
            get: { self.loginVM.errorMessage != nil },
            set: { _ in self.loginVM.errorMessage = nil }
        )
    }
    
    var body: some View {
        
        ZStack{
           
            ZStack{
                Image("sign_in")
                    .resizable()
                    .scaledToFit()
                    .frame(width: .screenWidth * 0.9, height: .screenHeight, alignment: .top)
          
            }
            
            VStack{
                
                Text("Create your groceries list")
                    .font(.customfont(.semibold, fontSize: 30))
                    .foregroundColor(.primaryText)
                    .multilineTextAlignment(.center)
                  
          
                
            }
            .padding(.bottom, .screenWidth * 0.9)
             
     
            VStack{
               
                InputField(text: $loginVM.username, placeholder: "Enter your email address")
                    .padding(.bottom, .screenWidth * 0.07)
                    .padding(.top, 40)
                
                
                SecureInputField(text: $loginVM.password, placeholder: "Enter your password", isShowPassword: $loginVM.isShowPassword)
                    .padding(.bottom, .screenWidth * 0.07)
                
                
                Button{
                    
                }label:{
                    Text("Forgot Password?")
                        .font(.customfont(.regular, fontSize: 18))
                        .foregroundColor(.primaryText)
                }
                .padding(.bottom, .screenWidth * 0.01)
              
              
                CustomButton(title: "Log In", didTap:
                        {
                    Task {
                        await loginVM.signIn(homeViewModel: homeViewModel)
                }
                })
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                
                HStack{
                    Text("Don't have an account?")
                        .font(.customfont(.semibold, fontSize: 18))
                        .foregroundColor(.primaryText)
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.blue)
                    }
                }
                    
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
        .navigationDestination(isPresented: $loginVM.isSignIn) {
            MainTabView()
        }
        .alert(isPresented: showAlertBinding, content: {
            Alert(
                title: Text("Error"),
                message: Text(loginVM.errorMessage ?? "Invalid error"),
                dismissButton: .default(Text("OK"))
            )
        })
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    
}

#Preview {
       
    NavigationStack{
        SignInView()
    }
       
}

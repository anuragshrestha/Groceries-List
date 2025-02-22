//
//  SignInView.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/21/25.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject var loginVM = MainViewModel.shared
    
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
               
                InputField(text: $loginVM.email, placeholder: "Enter your email address")
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
              
              
                CustomButton(title: "Log In")
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
        .navigationTitle("")
    }
    
    
}

#Preview {
       
    NavigationStack{
        SignInView()
    }
       
}

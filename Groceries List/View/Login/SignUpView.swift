//
//  SignUpView.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/21/25.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var mainVM = MainViewModel.shared;
    
    var body: some View {
        
     
            VStack{
                
                Text("Grocery Shopping App")
                    .font(.customfont(.bold, fontSize: 24))
                    .foregroundColor(.red.opacity(0.8))
                    .padding(.top, .topInsets + 20)
                
                
                ScrollView{
                    
                    VStack{
                        LineTextField(text: $mainVM.userName, title: "User name", placeholder: "Enter your user name")
                            .padding(.bottom, .screenWidth * 0.07)
                        
                        LineTextField(text: $mainVM.email, title: "Email", placeholder:"Enter your email", keyboardType: .emailAddress)
                            .padding(.bottom, .screenWidth * 0.07)
                        
                        
                        SecureLineField(text: $mainVM.password, title: "Password", placeholder: "Enter your password", isShowPassword: $mainVM.isShowPassword)
                            .padding(.bottom, .screenWidth * 0.07)
                        
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
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, .bottomInsets)
                }
                .padding(.top, 40)

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
        
    }
}

#Preview {
    SignUpView()
}

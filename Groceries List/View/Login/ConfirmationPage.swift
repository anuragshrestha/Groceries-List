//
//  ConfirmationPage.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/25/25.
//

import SwiftUI

struct ConfirmationPage: View {
    
    @StateObject var confirmationVM = ConfirmationPageViewModel()
    
    var email:String
    
    private var showAlertBinding: Binding<Bool> {
        Binding<Bool> (
            get: {self.confirmationVM.errorMessage != nil},
            set: {_ in self.confirmationVM.errorMessage = nil}
        )
    }
    
    var body: some View {
        
        VStack{
            
            InputField(text: $confirmationVM.confirmationCode, placeholder: "Enter your confirmation code")
                .padding(.bottom, .screenWidth * 0.05)
                .padding(.top, .topInsets)
            
            Button{
                confirmationVM.confirmSignUp()
            }label: {
                Text("Confirm code")
                    .font(.customfont(.semibold, fontSize: 24))
                    .foregroundColor(Color.white)
                    
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight:60,  maxHeight: 60)
            .background(Color.blue)
            .cornerRadius(12)
            .padding(.horizontal, 20)
             
        }
        .onAppear{
            confirmationVM.email = email
        }
        .ignoresSafeArea()
        .navigationDestination(isPresented: $confirmationVM.isConfirmed){
            SignInView()
        }
        .alert(isPresented: showAlertBinding) {
            Alert(
                title: Text("Error"),
                message: Text(confirmationVM.errorMessage ?? "An unknown error occured"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    NavigationStack{
        ConfirmationPage(email: "")
    }
}

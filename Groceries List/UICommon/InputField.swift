//
//  InputField.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/21/25.
//

import SwiftUI


struct InputField: View {
    
    @Binding var text: String
    @State var placeholder: String = "Enter your email address"

    
    var body: some View {
     
        TextField(placeholder, text: $text)
            .foregroundColor(.primaryText)
            .font(.customfont(.semibold, fontSize: 20))
            .multilineTextAlignment(.center)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
            .background(Color.white)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .overlay(RoundedRectangle(cornerRadius: 12)
            .stroke(Color.black, lineWidth: 2)
            )
            .padding(.horizontal, 20)
          
    }
}

struct SecureInputField: View{
    
    @Binding var text: String
    @State var placeholder: String = "Enter your password"
    @Binding var isShowPassword: Bool
    
    var body: some View{
        
        if(isShowPassword){
            TextField(placeholder, text: $text)
                .foregroundColor(.primaryText)
                .font(.customfont(.semibold, fontSize: 20))
                .multilineTextAlignment(.center)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .background(Color.white)
                .modifier(ShowButton(isShow: $isShowPassword))
                .overlay(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 2))
                .padding(.horizontal, 20)
        }else{
            SecureField(placeholder, text: $text)
                .font(.customfont(.semibold, fontSize: 20))
                .foregroundColor(.primaryText)
                .multilineTextAlignment(.center)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .modifier(ShowButton(isShow: $isShowPassword))
                .overlay(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 2))
                .padding(.horizontal, 20)
        }
    }
}

#Preview {
    
    struct PreviewWrapper: View {
        @State var text: String = ""
        
        var body: some View {
            InputField(text: $text)
                .padding(20)
        }
    }
    return PreviewWrapper()
    
}

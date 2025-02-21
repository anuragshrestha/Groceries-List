//
//  LineTextField.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/21/25.
//

import SwiftUI

struct LineTextField: View {
    
    @Binding var text: String //this value is owned by the parent view
    @State var title: String = "title"
    @State var placeholder:String = "placeholder"
    @State var keyboardType: UIKeyboardType = .default
    
    var body: some View {
      
        VStack{
            Text(title)
                .font(.customfont(.semibold, fontSize: 24))
                .foregroundColor(.black)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            
            TextField(placeholder, text: $text)
                .font(.customfont(.regular, fontSize: 22))
                .foregroundColor(.black)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
                .keyboardType(keyboardType)
                .frame(height: 40)
            
            Divider()
        }
    }
}

struct SecureLineField: View {
    
    @Binding var text: String
    @State var title: String = "title"
    @State var placeholder: String = "placeholder"
    @Binding var isShowPassword: Bool
    
    var body: some View{
        
        VStack{
            Text(title)
                .font(.customfont(.semibold, fontSize: 24))
                .foregroundColor(.black)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            if(isShowPassword){
                TextField(placeholder, text: $text)
                    .font(.customfont(.regular, fontSize: 22))
                    .foregroundColor(.black)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .modifier(ShowButton(isShow: $isShowPassword))
                    .frame(height: 40)
            }else {
                SecureField(placeholder, text: $text)
                    .font(.customfont(.regular, fontSize: 22))
                    .foregroundColor(.black)
                    .modifier(ShowButton(isShow: $isShowPassword))
                    .frame(height: 40)
            }
            
            Divider()
        }
    }
}

#Preview {

    //Declare the @State property outside the preview
    struct PreviewWrapper: View{
        @State private var text: String = ""  //Parent owns the state
        
        var body: some View{
            LineTextField(text: $text)
                .padding(20)
        }
    }
      
    return PreviewWrapper()
    
}

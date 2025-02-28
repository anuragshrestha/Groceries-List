//
//  TabButton.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/27/25.
//

import SwiftUI

struct TabButton: View {
    
    @State var title:String = "title"
    @State var icon: String = "Icon"
    var isSelect:Bool = false
    var didSelect: (() -> ())
    
    
    var body: some View {
        
        Button{
            didSelect()
        }label:{
            VStack{
                
                Image(systemName:icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                Text(title)
                    .font(.customfont(.semibold, fontSize: 20))
            }
        }
        .foregroundColor(isSelect ? .primary : .primaryText)
        .frame(minWidth: 0, maxWidth: .infinity)
        

        
        
     
    }
}

#Preview {
    TabButton{
        print("select")
    }
}

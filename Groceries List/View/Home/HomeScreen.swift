//
//  HomeScreen.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/27/25.
//

import SwiftUI

struct HomeScreen: View {
    
    // Sample grocery data
    let groceries = [
        ("Apples", "2 kg", "02/28/25"),
        ("Milk", "1 L", "03/01/25"),
        ("Bread", "1 Pack", "02/27/25"),
        ("Eggs", "12", "02/28/25"),
        ("Rice", "5 kg", "03/05/25")
    ]
    
    var body: some View {
    
        NavigationStack{
        
            VStack(spacing:0){
                    
                NavigationLink(destination: AddGrocery()) {
                    CustomButton(title: "Add Grocery")
                        .padding(.horizontal, 50)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
               
                }
                .buttonStyle(PlainButtonStyle())
                    
                    HStack{
                        Text("Grocery Name")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.customfont(.semibold, fontSize: 20))
                    
                        
                        Text("Qty")
                            .frame(width: 45, alignment: .center)
                            .font(.customfont(.semibold, fontSize: 20))
                        
                        Text("Date")
                            .frame(width: 95, alignment: .trailing)
                            .font(.customfont(.semibold, fontSize: 20))
                        
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
            
                    
                ZStack{
                    
                    Color.green.opacity(0.6)
                        .edgesIgnoringSafeArea(.bottom)
                        .frame(maxWidth: .infinity)
                        .ignoresSafeArea()
                    
                    ScrollView {
                        
                        VStack(spacing:8){
                            ForEach(groceries, id:\.0) { grocery in
                                HStack(spacing:5){
                                    Text(grocery.0)
                                        .frame(maxWidth: .infinity, alignment: .leading )
                                        .font(.system(size: 18))
                                        
                                        
                                    Text(grocery.1)
                                        .frame(width: 65, alignment: .center)
                                        .font(.system(size: 18))
                                    
                                    Text(grocery.2)
                                        .frame(width:85, alignment: .trailing)
                                        .font(.system(size: 18))
                                }
                                .padding(.top, 3)
                                
                                Divider()
                                    .background(Color.black)
                                
                            }
                        }
                      
                      }
                       .padding(.horizontal, 20)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
    
         
        }
        
    }


#Preview {
    NavigationStack{
        HomeScreen()
    }
  
}

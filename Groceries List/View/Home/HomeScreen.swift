//
//  HomeScreen.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/27/25.
//

import SwiftUI

struct HomeScreen: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
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
                
                List {
                   ForEach(viewModel.groceryLists) { groceryList in
                       HStack(spacing: 1) {
                           Text(groceryList.groceries.groceryName)
                               .frame(maxWidth: .infinity, alignment: .leading)
                               .font(.system(size: 18))
                           
                            Text(groceryList.groceries.quantity)
                               .frame(width: 55, alignment: .center)
                               .font(.system(size: 18))
                           
                           Text(groceryList.groceries.dueDate)
                               .frame(width:105, alignment: .trailing)
                               .font(.system(size: 18))
                       }
                       .frame(maxWidth: .infinity)
                   }
                }
                .listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
                .background(Color.gray.opacity(0.2))
                .onAppear{
                    Task {
                        await viewModel.fetchGroceries()
                    }
                }
                .refreshable {
                    await viewModel.fetchGroceries()
                }
               }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.2))
            }

        }
        
    }


#Preview {
    NavigationStack{
        HomeScreen()
    }
  
}

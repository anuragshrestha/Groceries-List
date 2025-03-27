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
                       let grocery = groceryList.groceries
                       let convertedDate = convertDate(from: grocery.dueDate)
                       
                       NavigationLink(
                        destination: UpdateGroceryList(
                            listId: groceryList.id,
                            groceryName: grocery.groceryName,
                            quantity: grocery.quantity,
                            dueDate: convertedDate
                        ))
                       {
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
    
        func convertDate(from string: String) -> Date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd" // Update this format to match your `dueDate` format
            return formatter.date(from: string) ?? Date()
        }
        
    }


#Preview {
    NavigationStack{
        HomeScreen()
    }
  
}

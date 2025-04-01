//
//  FavoriteScreen.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/27/25.
//

import SwiftUI

struct HistoryScreen: View {
    
    
    @StateObject var historyService = FetchHistoryGrocery()
    
    var body: some View {
       
        
        VStack(spacing: 0){
            
            Text("History Table")
                .frame(maxWidth: .infinity)
                .font(.customfont(.bold, fontSize: 24))
                .padding(.top, 20)
                .padding(.bottom, 20)
                .foregroundColor(Color.blue)
            
            HStack{
                Text("Grocery Name")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.customfont(.semibold, fontSize: 20))
                
                Text("Quantity")
                    .frame(width: 85, alignment: .center)
                    .font(.customfont(.semibold, fontSize: 20))
                
                Text("Bought on")
                    .frame(width: 115, alignment: .trailing)
                    .font(.customfont(.semibold, fontSize: 20))
            }
            .padding(.top, 10)
            .padding(.horizontal, 20)
            
            
            List{
                ForEach(historyService.groceryList) { groceryItem in
                    HStack(spacing: 1){
                        Text(groceryItem.groceryName)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.customfont(.semibold, fontSize: 18))
                        
                        Text(groceryItem.quantity)
                            .frame(width: 55, alignment: .center)
                            .font(.customfont(.semibold, fontSize: 18))
                        
                        Text(groceryItem.dueDate)
                            .frame(width: 105, alignment: .trailing)
                            .font(.customfont(.semibold, fontSize: 18))
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
            .background(Color.gray.opacity(0.2))
            .onAppear{
                Task{
                    print("fetching 1")
                    await historyService.fetchGroceries()
                }
            }
            .refreshable {
                print("fetching 2")
                await historyService.fetchGroceries()
            }
        }
        .background(Color.gray.opacity(0.2))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    
    func convertDate(from string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" 
        return formatter.date(from: string) ?? Date()
    }
}

#Preview {
    HistoryScreen()
}

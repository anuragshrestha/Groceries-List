//
//  UpdateGroceryList.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 3/25/25.
//

import SwiftUI

struct UpdateGroceryList: View {
    let listId: String
    
    @State var groceryName: String
    @State var quantity:String
    @State var date: Date
    @State var isDatePickerPresented: Bool = false
    
    var body: some View {
        
        ZStack{
            
            Color(.systemBackground)
                
            
            VStack{
                
                InputField(text: $groceryName, placeholder: "Update the grocery item")
                    .padding(.bottom, .bottomInsets)
                
                InputField(text: $quantity, placeholder: "Update grocery quantity")
                    .padding(.bottom, .bottomInsets)
                
                HStack {
                    
                    InputField(text: Binding(
                        get: {
                            formatDate(date)
                        },
                        set: { _ in
                            
                        }), placeholder: "Select date")
                    .disabled(true)
                    
                    
                    Button(action: {
                        isDatePickerPresented = true
                    }){
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                            .font(.customfont(.semibold, fontSize: 30))
                    }
                        
                    
                }
                .padding()
                
                HStack{
                    Button(action: {
                        print("list id: ", listId)
                    }){
                        Text("Update")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .font(.customfont(.semibold, fontSize: 18))
                            .cornerRadius(10)
                        
                    }
                    .padding()
                    
                    Button(action: {
                        print("list id: ", listId)
                    }){
                        Text("Delete")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .font(.customfont(.semibold, fontSize: 18))
                            .cornerRadius(10)
                        
                    }
                    .padding()
                    
                    Button(action: {
                        print("list id: ", listId)
                    }){
                        Text("Complete")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .font(.customfont(.semibold, fontSize: 14))
                            .cornerRadius(10)
                        
                    }
                    .padding()
                }
           
    
            }
            .navigationTitle("")
            .ignoresSafeArea()
            .sheet(isPresented: $isDatePickerPresented) {
                VStack {
                    DatePicker("Select Date", selection: $date, displayedComponents: [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                    
                    Button("Done") {
                        isDatePickerPresented = false
                    }
                    .font(.customfont(.semibold, fontSize: 18))
                    
                }
                .presentationDetents([.fraction(0.7)])
            }
            
        }
    }

    // Helper function to format date
     private func formatDate(_ date: Date) -> String {
         let formatter = DateFormatter()
         formatter.dateStyle = .medium
         return formatter.string(from: date)
     }
}

#Preview {
    UpdateGroceryList(listId: "adaHdiuvw1", groceryName: "Apple", quantity: "1", date: Date())
}

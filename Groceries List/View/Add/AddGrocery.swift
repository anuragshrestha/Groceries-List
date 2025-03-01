//
//  AddGrocery.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/28/25.
//

import SwiftUI

struct AddGrocery: View {
    
    @StateObject var addVM = AddGroceryViewModel()

    
    var body: some View {
        
        ZStack{
            
            Color(.systemBackground)
                
            
            VStack{
                
                InputField(text: $addVM.groceryItem, placeholder: "Add the grocery item")
                    .padding(.bottom, .bottomInsets)
                
                InputField(text: $addVM.quantity, placeholder: "Required grocery quantity")
                    .padding(.bottom, .bottomInsets)
                
                HStack {
                    
                    InputField(text: Binding(
                        get: {
                            formatDate(addVM.currentTime)
                        },
                        set: { _ in
                            
                        }), placeholder: "Select date")
                    .disabled(true)
                    
                    
                    Button(action: {
                        addVM.isDatePickerPresented.toggle()
                    }) {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                            .font(.customfont(.semibold, fontSize: 30))
                    }
                }
                .padding()
                
            }
            .navigationTitle("Add Grocery")
            .ignoresSafeArea()
            .sheet(isPresented: $addVM.isDatePickerPresented) {
                VStack {
                    DatePicker("Select Date", selection: $addVM.currentTime, displayedComponents: [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                    
                    Button("Done") {
                        addVM.isDatePickerPresented = false
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
    AddGrocery()
}

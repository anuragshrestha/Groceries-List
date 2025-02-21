//
//  MainViewModel.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/21/25.
//

import SwiftUI

class MainViewModel: ObservableObject {
    
    static var shared: MainViewModel = MainViewModel()
    
    @Published var userName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isShowPassword: Bool = false
    
    
    init( ) {
        
   
        
    }
}

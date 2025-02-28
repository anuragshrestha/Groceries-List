//
//  HomeViewModel.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/27/25.
//

import Foundation

class HomeViewModel: ObservableObject{
    
    @Published var selectedTab: Int = 0
    @Published var username: String = ""
    @Published var name:String = ""
}

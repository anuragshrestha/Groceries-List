//
//  MainTabView.swift
//  Groceries List
//
//  Created by Anurag Shrestha on 2/27/25.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var homeVM = HomeViewModel()
    
    var body: some View {
       
        VStack{
            TabView(selection: $homeVM.selectedTab) {
                HomeScreen().tag(0)
                HistoryScreen().tag(1)
            }
            .tabViewStyle(.automatic)
            
            HStack{
                
                TabButton(title: "Home", icon: "house.fill", isSelect: homeVM.selectedTab == 0){
                    DispatchQueue.main.async {
                        withAnimation {
                            homeVM.selectedTab = 0
                        }
                    }
                }
                
                TabButton(title: "History", icon: "clock.arrow.circlepath", isSelect: homeVM.selectedTab == 1){
                    DispatchQueue.main.async {
                        withAnimation {
                            homeVM.selectedTab = 1
                        }
                    }
                }
            }
            .padding(.bottom, 15)
            .padding(.top, 10)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.15), radius: 3, x:0, y: -2)
            
        }
        .navigationTitle("")
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

#Preview {
    
    NavigationStack{
        MainTabView()
    }
  
}

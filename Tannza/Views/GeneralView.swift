//
//  GeneralView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 09/03/2026.
//

import SwiftUI

struct GeneralView: View {
    var body: some View {
        
        TabView {
           
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            OrderView()
                .tabItem {
                    Label("Place Order", systemImage: "paperplane.fill")
                }
            
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock.fill")

                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")

                }
            
        }
        .tint(Color("Light"))
        
    }
}

#Preview {
    GeneralView()
}

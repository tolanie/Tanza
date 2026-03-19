//
//  OrderView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 09/03/2026.
//

import SwiftUI

struct OrderView: View {
    var body: some View {

        NavigationStack {
            
            ScrollView (showsIndicators: false) {
                
                VStack (alignment: .leading, spacing: 24) {
                    
                    
                    
                }
                
                .padding(.top)
                .padding(.bottom, 32)
                
            }
            
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(red: 0.95, green: 0.95, blue: 0.97))
            .ignoresSafeArea(.all)

            
            .navigationTitle("Book Logistics")
            .navigationBarTitleDisplayMode(.inline)
            
            .safeAreaInset(edge: .bottom) {
                

                
            }
        }

    }
}

#Preview {
    OrderView()
}

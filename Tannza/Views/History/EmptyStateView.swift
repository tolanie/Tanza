//
//  EmptyStateView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 27/03/2026.
//

import SwiftUI

struct EmptyStateView: View {
    let message: String
    var body: some View {
        VStack (spacing: 16) {
            ZStack {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color("lightbg").opacity(0.5))
                
                Image(systemName: "shippingbox.fill")
                    .font(.title2)
                    .foregroundColor(Color("Light"))
                
                Image(systemName: "doc.text.magnifyingglass")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(Color("Light"))
            }
            
            VStack(spacing: 8) {
                            Text("No transactions found")
                                .font(.system(size: 18, weight: .bold))
                            
                            Text(message)
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }
        }
        .padding(.bottom, 50)

    }
}

#Preview {
    EmptyStateView(message: "")
}

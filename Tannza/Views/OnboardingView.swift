//
//  OnboardingView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 19/02/2026.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        
        ZStack {
            Image("BGImage")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Your logistics \n starts here")
                           .font(.largeTitle)
                           .bold()
                           .foregroundColor(.white)
                    
                    Text("Track, manage, and optimize your logistics operations with ease.")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .lineLimit(nil)
                       
                }.padding(.horizontal, 40)
                    .padding(.top, 80)
            
                
                Spacer()
                
                Button {
                    print("Start Shipping button clicked")
                } label: {
                    Text("Start Shipping")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: 300)
                        .padding()
                        .background(Color("Light"))
                        .cornerRadius(16)
                        
                                                                    
                }.padding(.horizontal, 40)


                    
            }.padding()
        }
        
    }
}

#Preview {
    OnboardingView()
}

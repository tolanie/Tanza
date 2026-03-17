//
//  OnboardingView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 19/02/2026.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var goToNext = false
    
    var body: some View {
        
        let apiClient = APIClient()
                let authService = AuthService(apiClient: apiClient)
                let viewModel = LoginViewModel(authService: authService)
        
        NavigationStack {
            ZStack {
                Image("BGImage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Your logistics \n starts here")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("Track, manage, and optimize your logistics operations with ease.")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 80)
                    
                    Spacer()
                    
                    Button("Continue") {
                        goToNext = true
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: 300)
                    .padding()
                    .background(Color("Light"))
                    .cornerRadius(16)
                    .navigationDestination(isPresented: $goToNext) {
                        SignUpView(viewModel: viewModel)
                    }
                    
                }
                .padding()
            }
        }
    }
}
#Preview {
    OnboardingView()
}

//
//  ContentView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 19/02/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let apiClient = APIClient()
                let authService = AuthService(apiClient: apiClient)
                let viewModel = LoginViewModel(authService: authService)
//        OnboardingView()
        SignUpView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}

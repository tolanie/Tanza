//
//  SignUpView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 19/02/2026.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel: OtpViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                            
                VStack (alignment: .leading, spacing: 24) {
                    
                    // logo
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    
                    //heading text and underline
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Enter your mobile number")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        Text("We'll send you a verification code to confirm your number.")
                            .lineLimit(nil)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        
                    } .padding(.bottom, 10)
                    
                }
                
                HStack {
                    HStack (spacing: 6) {
                        Image("flagg")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text("+234")
                            .font(.subheadline)
                        
                        Image(systemName: "chevron.down")
                            .font(.caption)
                        
                    }
                    .padding()
                    .background(Color.gray .opacity(0.1))
                    .frame(height: 50)
                    .cornerRadius(8)
                    
                    TextField("9153065907", text: $viewModel.phoneNumber)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.gray .opacity(0.1))
                        .frame(height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                } .padding(.vertical, 20)
                
                            //sign up button
                VStack (spacing: 24) {
                    
                    ButtonView(title: "Sign up", backgroundColor: Color("Light"), isDisabled: false, foregroundColor: .white) {
                        viewModel.login()
                        debugPrint("Signup....")
                    }
                    
                    Text("By proceeding, you concent to get calls, Whatsapp or SMS messages, including by automated means, from LogiFlow and it's affiliates to the number provided and Hereby agree to our terms and condition.")
                        .font(.caption)
                        .foregroundColor(.black)
                        .lineLimit(nil)
                    
                }
                
                //or divider
                HStack{
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.4))
                    
                    Text("or")
                        .font(.body)
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.4))
                }.padding(.top, 10)
                
                //apple and google button
                VStack (spacing: 16) {
                    
                    ButtonView(title: "Continue with Google",
                               backgroundColor: .white,
                               hasOverlay: true, isDisabled: false,
                               icon: Image("google"),
                               foregroundColor: .black
                               
                    )
                    {
                        print("Google button tapped")
                    }
                    
                    
                    ButtonView(title: "Continue with Apple",
                               backgroundColor: .white,
                               hasOverlay: true, isDisabled: false,
                               icon: Image(systemName: "applelogo"),
                               foregroundColor: .black
                               
                    )
                    {
                        print("apple button tapped")
                    }
                    
                }.padding(.top, 16)
                
                
                Spacer()
                
                HStack(alignment: .center, spacing: 3) {
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                    
                    
                    Button {
                        print("Sign in tapped")
                    } label: {
                        Text("Sign in")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Light"))
                    }
                    
                }.frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .navigationDestination(isPresented: $viewModel.shouldNavigateToOTP) {
                OTPView()
            }
            .alert("Error", isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            )) {
                Button("OK") {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .overlay {
                if viewModel.isLoading {
                    ZStack {
                        Color.black.opacity(0.3)
                            .ignoresSafeArea()
                        
                        ProgressView()
                            .scaleEffect(1.5)
                            .tint(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    let apiClient = APIClient()
            let authService = AuthService(apiClient: apiClient)
            let viewModel = OtpViewModel(authService: authService)
    SignUpView(viewModel: viewModel)
}



//
//  LoginView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 04/03/2026.
//

import SwiftUI

struct LoginView: View {
    @State private var selectedTab = 0
    @State private var email = ""
    @State private var phone = ""
    
    @State private var emailError = ""
    @State private var phoneError = ""
    
    var isDisabled: Bool {
        if selectedTab == 0 {
            return email.isEmpty
        }else {
            return phone.isEmpty
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            VStack (alignment: .leading, spacing: 24) {
                
                // logo
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                //                //heading text and underline
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Welcome back")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text("Enter your email or mobile number to continue.")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    
                }
            }.padding(.bottom, 10)
            
            HStack{
                
                Button(action: {
                    selectedTab = 0
                }) {
                    Text("Email")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(selectedTab == 0 ? Color.black : Color.gray)
                        .fontWeight(selectedTab == 0 ? .semibold : .regular)
                        .padding()
                        .background(selectedTab == 0 ? Color.white : Color.clear)
                        .cornerRadius(8)
                }
                .padding(.all, 4)
                
                Button(action: {
                    selectedTab = 1
                }) {
                    Text("Mobile")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(selectedTab == 1 ? Color.black : Color.gray)
                        .fontWeight(selectedTab == 1 ? .semibold : .regular)
                        .padding()
                        .background(selectedTab == 1 ? Color.white : Color.clear)
                        .cornerRadius(8)
                }
                .padding(.all, 4)
            }
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.bottom, 8)
            
            //input field
            if selectedTab == 0 {
                VStack(alignment: .leading) {
                    
                    HStack (spacing: 2){
                        Text("Email")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                        
                        Text("(e.g. name@example.com)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    TextField("", text: $email)
                        .keyboardType(.emailAddress)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(emailError.isEmpty ? Color.gray.opacity(0.3) : Color.red, lineWidth: 1)
                        )
                    
                    if emailError.isEmpty {
                        Text(emailError)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
            } else {
                
                VStack(alignment: .leading) {
                    
                    HStack (spacing: 2){
                        Text("Mobile number")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                        
                        Text("(include country code)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
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
                        
                        TextField("", text: $phone)
                            .keyboardType(.numberPad)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(phoneError.isEmpty ? Color.gray.opacity(0.3) : Color.red, lineWidth: 1)
                            )
                        
                    }
                    
                    if phoneError.isEmpty {
                        Text(phoneError)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                
            }
            
            //continue button
            ButtonView(title: "Continue", backgroundColor: Color("Light"), isDisabled: isDisabled, foregroundColor: .white) {
                print("Continue btn tapped")
            }.padding(.top, 24)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 3) {
                Text("Don't have an account?")
                    .foregroundColor(.gray)
                
                
                Button {
                    print("Sign up tapped")
                } label: {
                    Text("Sign up")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Light"))
                }
                
            }.frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            
        }
        
        
        
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        
    }
    
    
}

#Preview {
    LoginView()
}

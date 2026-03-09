//
//  EmailView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 26/02/2026.
//

import SwiftUI

struct EmailView: View {
    
    @State private var email = ""
    @State private var hasEditedEmail = false
    
    var isEmailValid: Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        return  trimmedEmail.contains("@") &&
        trimmedEmail.contains(".") &&
        trimmedEmail.count >= 5
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            VStack (alignment: .leading, spacing: 24) {
                
                // logo
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                //heading text and underline
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Enter your email")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text("Add your email to aid in account recovery.")
                        .lineLimit(nil)
                        .foregroundColor(.gray)
                        .font(.subheadline)

                }
                

            } .padding(.top, 60)
            
            VStack {
                
                TextField("your email", text: $email)
                    .onChange(of: email) {                         hasEditedEmail = true
                    }
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color.gray .opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                hasEditedEmail && isEmailValid
                                ? Color.red
                                : Color.clear,
                                lineWidth: 1
                            )
                    )
                
                if hasEditedEmail && !isEmailValid {
                    Text("Please enter a valid email")
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .padding(.top, 16)
                }
                
            }.padding(.top, 16)
            
            Spacer()
            
            ButtonView(title: "Continue", backgroundColor: Color("Light"), isDisabled: !isEmailValid, foregroundColor: .white) {
                print("email tapped")
            }.padding(.bottom, 60)
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    EmailView()
}

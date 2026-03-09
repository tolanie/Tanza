//
//  SetupView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 26/02/2026.
//

import SwiftUI
import PhotosUI
import CoreLocation

struct SetupView: View {
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var profileImage: Image?
    @State private var fullName = ""
    @State private var password = ""
    @State private var address = ""
    @State private var showImagePicker = false
    @State private var showImageError = false
    @State private var showNameError = false
    @State private var showPasswordError = false
    @State private var showAddressError = false
    
    //checks if the form is valid
    var isFormValid: Bool {
        !fullName.isEmpty &&
        !password.isEmpty &&
        !address.isEmpty &&
        profileImage != nil
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            //back button
            Button {
                //action
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            .padding(.bottom, 16)
            
            VStack (alignment: .leading, spacing: 16) {
                
                // logo
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                //                //heading text and underline
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Complete your profile")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text("Let us know how to properly address you and secure your account.")
                        .lineLimit(nil)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    
                } .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Profile Photo")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                    
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        ZStack {
                            if let profileImage {
                                profileImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } else {
                                Circle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 80, height: 80)
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    
                    .onChange(of: selectedItem) {
                        Task {
                            if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                profileImage = Image(uiImage: uiImage)
                            }
                        }
                    }
                    
                    if showImageError {
                        Text("Profile Photo is required")
                            .font(.caption)
                            .foregroundColor(.red)
                        
                    }
                    
                    
                    
                } .padding(.bottom, 4)
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Full Name")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                    
                    VStack (spacing: 5) {
                        
                        TextField("", text: $fullName)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(showNameError ? Color.red : Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        
                        if showNameError {
                            Text("Full Name is required")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        
                    }
                    
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Password")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                    
                    VStack (spacing: 5) {
                        
                        SecureField("", text: $password)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(showPasswordError ? Color.red : Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        
                        if showPasswordError {
                            Text("Password is required")
                                .font(.caption)
                                .foregroundColor(.red)
                            
                        }
                        
                    }
                    
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Address")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                    
                    VStack (alignment: .leading, spacing: 8) {
                        
                        HStack {
                            TextField("", text: $address)
                            Image(systemName: "x.circle.fill")
                                .foregroundColor(.gray)
                        }
                        
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(showAddressError ? Color.red : Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        
                        if showAddressError {
                            Text("Address is required")
                                .font(.caption)
                                .foregroundColor(.red)
                            
                        }
                        
                        Button("Use current location") {
                            getCurrentLoacation()
                        } .font(.default)
                        
                    }
                    
                }
                
                //submit button
                
                ButtonView(title: "Complete Setup", backgroundColor: Color("Light"), isDisabled: !isFormValid, foregroundColor: .white) {
                    
                    validateForm()
                }
                .padding(.top, 16)
                
            }
            
            //            Spacer()
        }
        
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        
        
    }
    
    // validate form
    func validateForm() {
        showNameError = fullName.isEmpty
        showPasswordError = password.isEmpty
        showAddressError = address.isEmpty
        showImageError = profileImage == nil
        
    }
    
    func getCurrentLoacation() {
        print("Fetch location here")
    }
    
}

#Preview {
    SetupView()
}

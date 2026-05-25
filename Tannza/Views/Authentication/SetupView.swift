//
//  SetupView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 26/02/2026.
//

import SwiftUI
import PhotosUI
import CoreLocation
import CoreLocationUI

struct SetupView: View {
    @StateObject var viewModel: SetupViewModel
    @State private var selectedItem: PhotosPickerItem?
    @State private var profileImage: Image?
    @State private var fullName = ""
    @State private var address = ""
    @State private var showImagePicker = false
    @State private var showImageError = false
    @State private var showNameError = false
    @State private var showPasswordError = false
    @State private var showAddressError = false
    @StateObject private var locationManager = LocationManager()
    
    //checks if the form is valid
    var isFormValid: Bool {
        !fullName.isEmpty &&
        !viewModel.password.isEmpty &&
        !address.isEmpty &&
        profileImage != nil 
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            VStack (alignment: .leading, spacing: 16) {
                
                // logo
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                //                //heading text and underline
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(Strings.Setup.title)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text(Strings.Setup.subtitle)
                        .lineLimit(nil)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    
                } .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(Strings.Setup.profilePhotoLabel)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                    
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        ZStack {
                            if let profileImage {
                                profileImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                            } else {
                                Circle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 60, height: 60)
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
                                viewModel.setProfileImage(uiImage)
                            }
                        }
                    }
                    
                    
                    if showImageError {
                        Text(Strings.Setup.profilePhotoError)
                            .font(.caption)
                            .foregroundColor(.red)
                        
                    }
                    
                    
                    
                } .padding(.bottom, 4)
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(Strings.Setup.fullNameLabel)
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
                            Text(Strings.Setup.fullNameError)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        
                    }
                    
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(Strings.Setup.passwordLabel)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                    
                    VStack (spacing: 5) {
                        
                        SecureField("", text: $viewModel.password)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(showPasswordError ? Color.red : Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        
                        if showPasswordError {
                            Text(Strings.Setup.passwordError)
                                .font(.caption)
                                .foregroundColor(.red)
                            
                        }
                        
                    }
                    
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(Strings.Setup.addressLabel)
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
                            Text(Strings.Setup.addressError)
                                .font(.caption)
                                .foregroundColor(.red)
                            
                        }
                        
                        Button(Strings.Setup.useCurrentLocation) {
                            locationManager.requestLocation()
                        }.font(.default)
                        
                    }
                    
                }
                
                //submit button
                
                ButtonView(title: Strings.Setup.completeSetupButton, backgroundColor: Color("Light"), isDisabled: !isFormValid, foregroundColor: .white) {
                    
                    validateForm()
                }
                .padding(.top, 16)
                
            }
            
        }
        
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        //alert to show error
        .alert(Strings.Common.errorTitle, isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { if !$0 { viewModel.errorMessage = nil } }
        )) {
            Button(Strings.Common.okButton) { viewModel.errorMessage = nil }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
        .overlay {
            if viewModel.isLoading {
                ZStack {
                    Color.black.opacity(0.3).ignoresSafeArea()
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.white)
                }
            }
        }
        
        .onChange(of: locationManager.location) {
            if let location = locationManager.location {
                viewModel.usersAddress.lat = location.coordinate.latitude
                viewModel.usersAddress.lon = location.coordinate.longitude
                address = "Current Location"
            }
        }
        
        .navigationDestination(isPresented: $viewModel.shouldNavigateToHome) {
            HomeView()
        }
        
    }
    
    
    
    
    // validate form
    func validateForm() {
        showNameError = fullName.isEmpty
        showPasswordError = viewModel.password.isEmpty
        showAddressError = address.isEmpty
        showImageError = profileImage == nil
        let parts = fullName.trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
        viewModel.firstName = parts.first ?? ""
        viewModel.lastName = parts.dropFirst().joined(separator: " ")
        viewModel.usersAddress.name = address
        viewModel.setup()
    }
}

#Preview {
    let apiClient = APIClient()
    let authService = AuthService(apiClient: apiClient)
    let viewModel = SetupViewModel(authService: authService)
    SetupView(viewModel: viewModel)
}

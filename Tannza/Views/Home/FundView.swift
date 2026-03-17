//
//  FundView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 12/03/2026.
//

import SwiftUI

struct FundView: View {
    var body: some View {
        
        NavigationStack {
            
            VStack (alignment: .leading, spacing: 24) {
                
                Text("Choose how you'd like to add money to your wallet")
                
                VStack (alignment: .leading, spacing: 16) {
                    HStack {
                        HStack (spacing: 16) {
                            ZStack {
                                Circle()
                                    .frame(width: 56, height: 56)
                                    .foregroundColor(Color("lightbg"))
                                
                                Image(systemName: "shippingbox.fill")
                                    .font(.title2)
                                    .foregroundColor(Color("Light"))
                            }
                            
                            VStack (alignment: .leading, spacing: 4) {
                                Text("Bank Transfer")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                
                                Text("Free . Instant")
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                            
                        }
                        Button {
                            print("Use btn clicked")
                        } label: {
                            Text("Use this")
                            
                        }
                        .padding(8)
                        .padding(.horizontal, 8)
                        .foregroundColor(.white)
                        .background(Color("Light"))
                        .cornerRadius(100)
                    }
                    
                    
                    Text("Transfer to this account")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 10) {
                        
                        HStack {
                            
                            Text("Account Number")
                                .font(.headline)
                                .fontWeight(.regular)
                            
                            Spacer()
                            
                            HStack {
                                Text("1238495740")
                                    .fontWeight(.medium)
                                Button {
                                    print("Use btn clicked")
                                } label: {
                                    Text("Copy")
                                    
                                }
                                .padding(8)
                                .foregroundColor(Color("Light"))
                                .background(Color("lightbg"))
                                .cornerRadius(8)
                                
                                
                            }
                            
                        }
                        
                        HStack {
                            
                            Text("Bank Name")
                                .font(.headline)
                                .fontWeight(.regular)
                            
                            Spacer()
                            
                            HStack {
                                Text("Test Bank")
                                    .fontWeight(.medium)
                                Button {
                                    print("Use btn clicked")
                                } label: {
                                    Text("Copy")
                                    
                                }
                                .padding(8)
                                .foregroundColor(Color("Light"))
                                .background(Color("lightbg"))
                                .cornerRadius(8)
                                
                                
                            }
                            
                        }
                        
                        HStack {
                            
                            Text("Account Name")
                                .font(.headline)
                                .fontWeight(.regular)
                            
                            Spacer()
                            
                            Text("TEST-MANAGED-ACCOUNT")
                                .fontWeight(.medium)
                        }
                        
                        .padding(.bottom)
                        
                        HStack {
                            
                            Image(systemName: "lightbulb.max")
                            
                            Text("This is your dedicated account. Any transfer to this account will be automatically added to your wallet. It may take up to 3Mins to process.")
                                .font(.headline)
                                .fontWeight(.regular)

                        }

                        .padding(8)
                        .foregroundColor(Color("Light"))
                        .background(Color("lightbg"))
                        .cornerRadius(8)
                        
                    }
                    
                }
                
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.white))
                .cornerRadius(8)
                .shadow(radius: 1.5)
                
                Button {
                    print("Make payment btn cliked")
                } label: {
                    HStack {
                        Text("Make Payment Option")
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                    }
                }

                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .padding(.top, 40)
            .background(Color(red: 0.95, green: 0.95, blue: 0.97))
            .ignoresSafeArea(.all)
            
            
            .navigationTitle("Fund Account")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "chevron.left")
                }
            }
        }
    }
}

#Preview {
    FundView()
}

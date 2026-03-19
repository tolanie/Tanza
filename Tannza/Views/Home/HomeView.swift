//
//  HomeView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 09/03/2026.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        ScrollView (showsIndicators: false) {
        
        VStack (alignment: .leading, spacing: 24) {
            
            HStack {
                
                VStack (alignment: .leading, spacing: 8) {
                    Text("Hello,")
                        .foregroundColor(.gray)
                    
                    Text("Tolani Abiodun")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 60, height: 60)
                
            }
            
            //Wallet Balance card
            
            VStack (alignment: .leading, spacing: 16) {
                
                HStack {
                    Text("Wallet Balance")
                        .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                    
                    Spacer()
                    
                    Button {
                        print("")
                    } label: {
                        HStack (spacing: 2) {
                            Image(systemName: "plus")
                            Text("Add Money")
                        }
                        .padding(8)
                        .padding(.horizontal, 8)
                        .foregroundColor(Color("Light"))
                        .background(Color("lightbg"))
                        .cornerRadius(100)
                    }
                    
                }
                
                VStack (alignment: .leading, spacing: 8) {
                    
                    HStack (spacing: 0) {
                        Image(systemName: "nairasign")
                        Text("0")
                    }
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    
                    
                    Text("Available for transactions")
                        .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                        .font(.subheadline)
                    
                }
                
                
            }
            .padding()
            .background(Color("Light"))
            .cornerRadius(8)
            
            //send and recieve cards
            HStack (spacing: 16) {
                
                Button {
                    print("Send btn clicked")
                } label: {
                    VStack (spacing: 10) {
                        ZStack {
                            Circle()
                                .frame(width: 56, height: 56)
                                .foregroundColor(Color("lightbg"))
                            
                            Image(systemName: "shippingbox.fill")
                                .font(.title2)
                                .foregroundColor(Color("Light"))
                        }
                        
                        Text("Send Package")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                    }
                }
                
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.white))
                .cornerRadius(8)
                .shadow(radius: 1.5)
                
                
                Button {
                    print("Receive btn clicked")
                } label: {
                    VStack (spacing: 10) {
                        ZStack {
                            Circle()
                                .frame(width: 56, height: 56)
                                .foregroundColor(Color("lightbg"))
                            
                            Image(systemName: "arrow.down.square.fill")
                                .font(.title2)
                                .foregroundColor(Color("Light"))
                        }
                        
                        Text("Receive Package")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                    }
                }
                
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.white))
                .cornerRadius(8)
                .shadow(radius: 1.5)
                
            }
            
            VStack (alignment: .leading, spacing: 16) {
                Text("Did you know?")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text("You can fund your account via bank transfer")
                    .font(.subheadline)
                
                Button {
                    print("Fund btn clicked")
                } label: {
                    Text("Fund Wallet")
                    
                }
                .padding(8)
                .padding(.horizontal, 8)
                .foregroundColor(.white)
                .background(Color("Light"))
                .cornerRadius(100)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.white))
            .cornerRadius(8)
            .shadow(radius: 1.5)
            
            VStack {
                
                HStack {
                    Text("Recent Transactions")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button {
                        // action
                    } label: {
                        Text("See all")
                            .foregroundColor(Color("Light"))
                            .fontWeight(.medium)
                    }
                }
                
                VStack (spacing: 10) {
                    
                    Image(systemName: "list.clipboard.fill")
                        .font(.title)
                        .foregroundColor(Color("Light"))
                    
                    Text("No recent transactions")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("Your transaction history will appear here")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.white))
                .cornerRadius(8)
                .shadow(radius: 1.5)
                
            }
                        
            
        }
    }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .padding(.top, 40)
        .background(Color(red: 0.95, green: 0.95, blue: 0.97))
        .ignoresSafeArea(.all)
        
        
        
    }
}

#Preview {
    HomeView()
}

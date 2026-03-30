//
//  OrderView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 09/03/2026.
//

import SwiftUI

struct OrderView: View {
    
    @State private var pickup = ""
    @State private var activeSection: ActiveSection = .none
    @State private var phone: String = ""
    
    struct RequiredLabel: View {
        let title: String
        
        var body: some View {
            HStack(spacing: 2) {
                        Text(title)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text("*")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
        }
    }
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView (showsIndicators: false) {
                
                ExpandableSection(title: "Pickup & Sender information",
                               
                icon: "location.fill",
                section: .sender,
                activeSection: $activeSection,
                content: AnyView(
                                    
                VStack (alignment: .leading, spacing: 16) {
                                        
                VStack (alignment: .leading, spacing: 8) {
                   
                    // the text field logic, Pickup location input
                RequiredLabel(title: "Pickup Location")
                TextField("Select Pickup Location", text: $pickup)
                        .textFieldStyle(.roundedBorder)
                    
                    RequiredLabel(title: "Sender Phone Number")
                    TextField("Enter sender's phone number", text: $phone)
                        .textFieldStyle(.roundedBorder)

                }
                                        
                }
                                    
                ))
                
            }
            
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(red: 0.95, green: 0.95, blue: 0.97))
            //            .ignoresSafeArea(bottom)
            
            
            .navigationTitle("Book Logistics")
            .navigationBarTitleDisplayMode(.inline)
            
            .safeAreaInset(edge: .bottom) {
                bottomBar
            }
        }
        
    }
}

extension OrderView {
    var bottomBar: some View {
        HStack {
            VStack (alignment: .leading) {
                HStack{
                    Image(systemName: "nairasign")
                    Text("0")
                }
                .font(.title)
                .foregroundColor(.black)
                
                Text("Total Amount")
            }
            
            Spacer()
            
            Button {
                print("Booked btn clicked")
            } label: {
                Text("Book Now")
            }
            
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        
        
    }
}

#Preview {
    OrderView()
}

//
//  OrderView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 09/03/2026.
//

import SwiftUI

struct OrderView: View {
    
    @State private var pickup = ""
    @State private var pickupPhone: String = ""
    
    @State private var dropoff = ""
    @State private var dropoffPhone: String = ""
    
    @State private var activeSection: ActiveSection = .none
    
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
                
//                ExpandableSection(title: "Pickup & Sender information",
//                               
//                icon: "location.fill",
//                section: .sender,
//                activeSection: $activeSection,
//                content: AnyView
                ExpandableSection(title: "Pickup & Sender information",
                                  icon: "location.fill",
                                  section: .sender,
                                  activeSection: $activeSection                                                ){
                    
                    VStack (alignment: .leading, spacing: 16) {
                        
                        VStack (alignment: .leading, spacing: 8) {
                            
                            // the text field logic, Pickup location input
                            RequiredLabel(title: "Pickup Location")
                            TextField("Select Pickup Location", text: $pickup)
                                .textFieldStyle(.roundedBorder)
                            
                            RequiredLabel(title: "Sender Phone Number")
                            TextField("Enter sender's phone number", text: $pickupPhone)
                                .textFieldStyle(.roundedBorder)
                            
                        }
                        Button {
                            //Button action
                        } label: {
                            
                            HStack{
                                Image(systemName: "square")
                                Text("Use my mobile")
                            }

                        }
                    }
                }
                
                // Delivery locations where they can add multiple delivery locations and when the add more the number increases e.g 2/10 or 5/10
                VStack {
                    HStack{
                        Image(systemName: "truck.box.fill")
                            .foregroundColor(Color("Light"))
                        
                        Text("Delivery Location")
                            .font(.headline)
                        
                        Spacer()
                        Text("1/10")
                            .foregroundColor(.gray)
                    }
                    
                    ExpandableSection(title: "Delivery Location",
                                      icon: "truck.box.fill",
                                      section: .reciever, activeSection: $activeSection
                    ) {
                        VStack (alignment: .leading, spacing: 16) {
                            VStack (alignment: .leading) {
                                
                                RequiredLabel(title: "Drop-off Address")
                                TextField("Select drop-off location", text: $dropoff)
                                    .textFieldStyle(.roundedBorder)
                            }
                            
                            Button {
                                //Button action
                            } label: {
                                
                                HStack{
                                    Image(systemName: "person.spatialaudio.stereo.3d.fill")
                                    Text("Address book")
                                        .font(.subheadline)
                                }

                            }
                            
                            VStack (alignment: .leading) {
                                
                                RequiredLabel(title: "Drop-off Address")
                                TextField("Select drop-off location", text: $dropoff)
                                    .textFieldStyle(.roundedBorder)
                            }
                            
                            VStack (alignment: .leading) {
                                
                                RequiredLabel(title: "Phone")
                                TextField("Recipient's phone", text: $dropoffPhone)
                                    .textFieldStyle(.roundedBorder)
                            }
                        }
                    }
                }
                .padding(.top, 16)
                
                Button(action: {
                    //buttun action
                }) {
                    HStack{
                        Image(systemName: "plus.circle.fill")
                        Text("Add Another Delivery")
                            .fontWeight(.medium)
                    }
                    .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                }
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                    .foregroundColor(.blue)
                )
                .padding(.vertical)
                
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

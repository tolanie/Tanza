//
//  OrderView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 09/03/2026.
//

import SwiftUI

struct OrderView: View {
    var body: some View {

        NavigationStack {
            
            ScrollView (showsIndicators: false) {
                
                VStack (alignment: .leading, spacing: 24) {
                    
                    DisclosureGroup("Pickup & Sender Information") {
                        VStack (alignment: .leading, spacing: 8) {
                            TextField("Select Pickup", text: .constant(""))
                                .textFieldStyle(.roundedBorder)
                            
                            TextField("Select Pickup", text: .constant(""))
                                .textFieldStyle(.roundedBorder)
                        }
                    }
                    
                }
                
                .padding(.top)
                .padding(.bottom, 32)
                
            }
            
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(red: 0.95, green: 0.95, blue: 0.97))
            .ignoresSafeArea(.all)

            
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

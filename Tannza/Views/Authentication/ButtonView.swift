//
//  ButtonView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 20/02/2026.
//

import SwiftUI

struct ButtonView: View {
    
    var title: String
    var backgroundColor: Color
    var hasOverlay: Bool = false
    var isDisabled: Bool
    var icon: Image? = nil
    var foregroundColor: Color
    var action: () -> Void
    
    
    
    var body: some View {
        Button {
            //action
        } label: {
            HStack (spacing: 6) {
                if let icon {
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                
                Text(title)
            }
                .foregroundColor(foregroundColor)
                .frame(maxWidth: .infinity)
                .padding()
                .background(isDisabled ? Color.gray : backgroundColor)
                .cornerRadius(16)
                .overlay{
                    if hasOverlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    }
}        }
    }
}

#Preview {
    ButtonView(title: "", backgroundColor: Color("Light"), hasOverlay: true, isDisabled: false, icon: Image("Google"), foregroundColor: .black) {
        print("button tapped")
    }
}


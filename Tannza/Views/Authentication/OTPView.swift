//
//  OTPView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 24/02/2026.
//

import SwiftUI
import SwiftData

struct OTPView: View {
    @Environment(\.dismiss) var dismiss
    @State private var timeRemaining = 60
    @State var timer: Timer?
    @State private var otpText = ""
    @FocusState private var isFocused: Bool
    @Query var users: [UserData]
    
    var body: some View {

        VStack(alignment: .leading, spacing: 16) {
            
            //back button
//            Button {
//                //action
//            } label: {
//                Image(systemName: "chevron.left")
//                    .font(.title2)
//                    .foregroundColor(.black)
//            }
//            .padding(.bottom, 32)
            
            VStack (alignment: .leading, spacing: 24) {
                
                // logo
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                //heading text and underline
                VStack(alignment: .leading, spacing: 18) {
                    Text("Enter the 4-digit code sent to you at  \(users.first?.phoneNumber ?? "")")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Changed your mobile number?")
                            .lineLimit(nil)
                            .foregroundColor(.gray)
                            .font(.body)
                            .underline()
                    }
                    
                } .padding(.bottom, 10)
                

            }
            
            // the 4 boxes
            HStack (spacing: 20) {
                
                ForEach(0..<4) {
                    index in
                    ZStack{
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(borderColor(for: index), lineWidth: 2)
                            .frame(width: 60, height: 60)
                        Text(digit(at: index))
                            .font(.title)
                        
                    }
                }
                
            }
            
            .onTapGesture {
                isFocused = true
            }
            
            //Hidden text field
            TextField("", text: $otpText)
                .keyboardType(.numberPad)
                .focused($isFocused)
                .frame(width: 0, height: 0)
                .opacity(0.01)
                .onChange(of: otpText) {
                    if otpText.count > 4 {
                        otpText = String(otpText.prefix(4))
                    }
                }
            
            Button {
                //action
            } label: {
                Text("Resend code via SMS (\(formattedTime))")
                    .foregroundColor(.gray)
                    .font(.body)
                    .onTapGesture {
                        if timeRemaining == 0 {
                            startTimer()
                        }
                    }
            }
            
            Spacer()
                .onAppear{
                    isFocused = true
                    startTimer()
                }
            
            
            ButtonView(title: "Next", backgroundColor: Color("Light"), isDisabled: otpText.count < 4, foregroundColor: .white) {
                print("Next btn tapped")
            }.padding(.bottom, 60)
                .disabled(otpText.count < 4)

            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    //Timer function
    func startTimer() {
        timer?.invalidate()
        timeRemaining = 60
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            _ in if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
            }
        }
    }
    
    var formattedTime: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    //get nuber for each box
    func digit(at index: Int) -> String {
        if index < otpText.count {
            let stringIndex = otpText.index(otpText.startIndex, offsetBy: index)
            return String(otpText[stringIndex])
        }
        
        return ""
    }
    
    //change border color
    func borderColor(for index:Int) -> Color {
        if otpText.count == index {
            return .black
        } else {
            return .gray
        }
    }
    
    
}

#Preview {
    OTPView()
}

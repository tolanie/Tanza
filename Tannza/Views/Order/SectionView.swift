import SwiftUI

enum ActiveSection {
    case none, sender, reciever
}

struct ExpandableSection: View {
    let title: String
    let icon: String
    let section: ActiveSection
    @Binding var activeSection: ActiveSection
    let content: AnyView
    
    var body: some View {
        VStack(spacing: 0) {
            
            // THE HEADER
            Button(action: {
                withAnimation(.easeInOut) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                    if activeSection == section {
                                        activeSection = .none
                                    } else {
                                        activeSection = section
                                    }
                                }
                }
            }) {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(Color("Light"))
                    
                    Text(title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: activeSection == section ? "minus" : "plus")
                        .foregroundColor(.gray)
                }
                .padding()
            }
            .buttonStyle(PlainButtonStyle())
            
            //THE CONTENT
            if activeSection == section {
                VStack {
                    // This adds a light line between the title and the form
                    Divider().padding(.horizontal)
                    
                    content
                        .padding()
                }
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
//        .padding(.horizontal)
    }
}

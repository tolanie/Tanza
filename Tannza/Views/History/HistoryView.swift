//
//  HistoryView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 09/03/2026.
//

import SwiftUI

//transaction model
struct Transaction: Identifiable {
    
    let id = UUID()
    let type: TransactionType
    let amount: Double
    let date: Date
}

enum TransactionType: String, CaseIterable {
    case all = "All"
    case deposits = "Deposit"
    case orders = "Orders"
}

struct HistoryView: View {
    @State private var selectedTab: TransactionType = .all
    
    @State private var transactions: [Transaction] = []
    
    @Environment(\.dismiss) var dismiss
    
    //The description text logic
    var emptyStateMessage: String {
        switch selectedTab {
        case .all:
            return "Your transaction history will appear here"
        case .deposits:
            return "Your deposit history will appear here"
        case .orders:
            return "Your order history will appear here"
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Divider()
                    // the top buttons
                    HStack (spacing: 8) {
                        ForEach(TransactionType.allCases, id: \.self) { tab in
                            
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    selectedTab = tab
                                }
                            }) {
                                Text(tab.rawValue)
                                    .font(.system(size: 14, weight: .medium))
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 10)
                                    .background(selectedTab == tab ? Color.green : Color.gray.opacity(0.1))
                                    .foregroundColor(selectedTab == tab ? .white : .gray)
                                    .clipShape(Capsule())
                                
                            }
                        }
                        
                    }
                    .padding()
                    Divider()
                    
                    ZStack {
                        Color(UIColor.systemBackground)
                        
                        if filteredTransactions.isEmpty {
                            Spacer()
                            EmptyStateView(message: emptyStateMessage)
                            Spacer()
                            Spacer()
                        } else {
                            List(filteredTransactions) { tx in
                                HStack {
                                    Text(tx.type.rawValue)
                                    Spacer()
                                    Text("$\(tx.amount, specifier: "%.2f")")
                                }
                            }
                            .listStyle(.plain)
                        }
                    }
                }
                
            }
            
            
            .navigationTitle("Transaction History")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    
                }
            }
            
            .onAppear() {
                //call api here
            }
        }
    }
    
    // Filter logic helper
    var filteredTransactions: [Transaction] {
        if selectedTab == .all {
            return transactions
        } else {
            return transactions.filter { $0.type == selectedTab }
        }
        
    }
    
}
#Preview {
    HistoryView()
}

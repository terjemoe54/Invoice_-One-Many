//
//  ContentView.swift
//  Invoice_ One-Many
//
//  Created by Terje Moe on 03/12/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
   
    @Query private var paytos: [Customer]
    
    @State private var payto: String = ""
    
    var body: some View {
        NavigationView {
            List {
                Section("Customer: ") {
                    TextField("Enter Customer Here", text: $payto)
                    Button("Add Customer") {
                        context.insert(Customer(title: payto))
                        payto = ""
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(payto.isEmpty)
               
                }
                
                Section("Customers") {
                    ForEach(paytos) { payto in
                        Text(payto.title)
                            .swipeActions {
                                Button(role: .destructive){
                                    withAnimation {
                                        context.delete(payto)
                                    }
                                } label: {
                                    Label("Delete" , systemImage: "trash.fill")
                                }
                            }
                    }
                }
                
            }
            .navigationTitle("Create Customer")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

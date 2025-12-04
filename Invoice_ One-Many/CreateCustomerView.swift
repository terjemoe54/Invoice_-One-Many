//
//  ContentView.swift
//  Invoice_ One-Many
//
//  Created by Terje Moe on 03/12/2025.
//

import SwiftUI
import SwiftData

struct CreateCustomerView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
   
    @Query private var customers: [Customer]
    
    @State private var title: String = ""
    
    var body: some View {
        NavigationView {
            List {
                Section("Customer: ") {
                    TextField("Enter Customer Here", text: $title)
                    Button("Add Customer") {
                        withAnimation{
                            let customer = Customer(title: title)
                            modelContext.insert(customer)
                            customer.invoices = []
                            title = ""
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(title.isEmpty)
                
                }
                
                Section("Customers") {
                    ForEach(customers) { customer in
                        Text(customer.title)
                            .swipeActions {
                                Button(role: .destructive){
                                    withAnimation {
                                        modelContext.delete(customer)
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
    CreateCustomerView()
}

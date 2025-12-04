//
//  CreateInvoiceView.swift
//  Invoice_ One-Many
//
//  Created by Terje Moe on 04/12/2025.

import SwiftUI
import SwiftData

struct CreateInvoiceView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query private var invoices: [Invoice]
    @Query private var customers: [Customer]
    
    @State private var invoice = Invoice()
    @State private var selectedCustomer: Customer?
    
   var body: some View {
       NavigationStack {
           List {
               Section("Invoice Title"){
                   TextField("Name", text: $invoice.title)
               }
               
               Section("General"){
                   DatePicker("Chose a Date", selection: $invoice.dueDate)
                   Toggle("Is Paid:", isOn: $invoice.isPaid)
               }
               
               Section("Select a Customer") {
                   Picker("", selection: $selectedCustomer){
                      ForEach(customers) { customer in
                           Text(customer.title)
                              .tag(customer as Customer?)
                       }
                      .labelsHidden()
                      .pickerStyle(.inline)
                       Text("None")
                           .tag(nil as Customer?)
                   }
               }
      
               Section {
                   Button("Create"){
                       save()
                       dismiss()
                   }
                   
               }
           }
           .navigationTitle("Create Invoice")
           .toolbar {
               ToolbarItem(placement: .cancellationAction){
                   Button("Dismiss"){
                       dismiss()
                   }
               }
               
               ToolbarItem(placement: .primaryAction){
                   Button("Done"){
                       save()
                       dismiss()
                   }
                   .disabled(invoice.title.isEmpty)
               }
           }
       }
    }
}

#Preview {
    CreateInvoiceView()
        .modelContainer(for: Invoice.self)
}

extension CreateInvoiceView {
    
    func save() {
        modelContext.insert(invoice)
        invoice.customer = selectedCustomer
        selectedCustomer?.invoices?.append(invoice)
        
    }
}

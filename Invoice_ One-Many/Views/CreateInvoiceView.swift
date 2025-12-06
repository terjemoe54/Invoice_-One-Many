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
                Section("Faktura For:"){
                    TextField("Navn", text: $invoice.title)
                }
                
                Section("Detaljer"){
                    DatePicker("Forfalls Dato", selection: $invoice.dueDate)
                    Toggle("Betalt:", isOn: $invoice.isPaid)
                }
                
                Section("Velg en Kunde") {
                    Picker("", selection: $selectedCustomer){
                        ForEach(customers) { customer in
                            Text(customer.title)
                                .tag(customer as Customer?)
                        }
                        .labelsHidden()
                        .pickerStyle(.inline)
                        Text("Ingen")
                            .tag(nil as Customer?)
                    }
                }
                
                Section {
                    Button("Opprett"){
                        save()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Opprett Faktura")
            .toolbar {
                ToolbarItem(placement: .cancellationAction){
                    Button("Avslutt"){
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .primaryAction){
                    Button("Ferdig"){
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

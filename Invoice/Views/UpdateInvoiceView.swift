//
//  UpdateToDoView.swift
//  ToDos
//
//  Created by Tunde Adegoroye on 08/06/2023.
//

import SwiftUI
import SwiftData

struct UpdateInvoiceView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var selectedCustomer: Customer?
    
    @Query private var customers: [Customer]
    
    @Bindable var invoice: Invoice

    var body: some View {
        List {
            Section("Faktura For") {
                TextField("Navn", text: $invoice.title)
            }
            
            Section {
                DatePicker("Forfallsdato",
                           selection: $invoice.dueDate, displayedComponents: .date)
                Toggle("Betalt ?", isOn: $invoice.isPaid)
            }
            
            Section("Velg en Kunde") {
                Picker("", selection: $invoice.customer){
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
                Button("Oppdater") {
                    dismiss()
                }
            }
        }
        .navigationTitle("Oppdater Faktura")
    }
}

#Preview {
    UpdateInvoiceView(invoice: Invoice())
        .modelContainer(for: Invoice.self)
}

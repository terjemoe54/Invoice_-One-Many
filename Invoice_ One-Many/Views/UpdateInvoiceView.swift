//
//  UpdateToDoView.swift
//  ToDos
//
//  Created by Tunde Adegoroye on 08/06/2023.
//

import SwiftUI
import SwiftData

//class OriginalToDo {
//    var title: String
//    var dueDate: Date
//    var isPaid: Bool
//    
//    init(item: Invoice) {
//        self.title = item.title
//        self.dueDate = item.dueDate
//        self.isPaid = item.isPaid
//    }
//}

struct UpdateInvoiceView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var selectedCustomer: Customer?

    @Bindable var invoice: Invoice

    var body: some View {
        List {
            
            Section("Invoice title") {
                TextField("Name", text: $invoice.title)
            }
            
            Section {
                DatePicker("Choose a date",
                           selection: $invoice.dueDate)
                Toggle("Important?", isOn: $invoice.isPaid)
            }
            
            Section {
                Button("Update") {
                    dismiss()
                }
            }
        }
        .navigationTitle("Update Invoice")
    }
}

#Preview {
    UpdateInvoiceView(invoice: Invoice())
        .modelContainer(for: Invoice.self)

}

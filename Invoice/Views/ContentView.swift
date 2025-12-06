//
//  ContentView.swift
//  ToDos
//
//  Created by Tunde Adegoroye on 06/06/2023.
// bra

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var invoices: [Invoice]
    
    @State private var showCreateCustomer = false
    @State private var showCreateInvoice = false
    @State private var invoiceToEdit: Invoice?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(invoices) { invoice in
                   HStack {
                        VStack(alignment: .leading) {
//                            if invoice.isPaid {
//                                HStack{
//                                    Text("PAID")
//                                        .font(.system(size: 16,weight: .bold))
//                                        .foregroundStyle(.green)
//                                        
//                                    Image(systemName: "heart.fill")
//                                        .symbolVariant(.fill)
//                                        .foregroundColor(.red)
//                                        .font(.system(size: 16,weight: .bold))
//                                        .bold()
//                                }
//                            }
                            
                            Text(invoice.title)
                                .font(.system(size: 15,weight: .bold))
                               
                            Text("\(invoice.dueDate, format: Date.FormatStyle(date: .numeric, time: .shortened))")
                                .font(.callout)
                            HStack{
                                if let customer = invoice.customer {
                                    Text(customer.title)
                                        .foregroundStyle(Color.blue)
                                        .bold()
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                        .background(Color.blue.opacity(0.1),
                                                    in: RoundedRectangle(cornerRadius: 8,
                                                                         style: .continuous))
                                }
                                // her
                                if invoice.isPaid {
                                    HStack{
                                        Text("PAID")
                                            .font(.system(size: 16,weight: .bold))
                                            .foregroundStyle(.green)
                                        
                                        Image(systemName: "heart.fill")
                                            .symbolVariant(.fill)
                                            .foregroundColor(.red)
                                            .font(.system(size: 16,weight: .bold))
                                            .bold()
                                    }
                                }
                            }
                        }
      
                        Spacer()
                        
                        Button {
                            withAnimation {
                                invoice.isPaid.toggle()
                            }
                        } label: {
                            
                            Image(systemName: "checkmark")
                                .symbolVariant(.circle.fill)
                                .foregroundStyle(invoice.isPaid ? .green : .gray)
                                .font(.largeTitle)
                        }
                        .buttonStyle(.plain)
                    }
                    .swipeActions {
                        
                        Button(role: .destructive) {
                            
                            withAnimation {
                                modelContext.delete(invoice)
                            }
                            
                        } label: {
                            Label("Slett", systemImage: "trash.fill")
                        }
                        
                        Button {
                            invoiceToEdit = invoice
                        } label: {
                            Label("Endre", systemImage: "pencil")
                        }
                        .tint(.orange)
                    }
                }
            }
            .navigationTitle("Faktura Liste")
            .bold()
            .sheet(item: $invoiceToEdit,
                   onDismiss: {
                invoiceToEdit = nil
            },
                   content: { editInvoice in
                NavigationStack {
                    UpdateInvoiceView(invoice: editInvoice)
                        .interactiveDismissDisabled()
                }
            })
            .sheet(isPresented: $showCreateCustomer,
                   content: {
                NavigationStack {
                    CreateCustomerView()
                }
            })
            .sheet(isPresented: $showCreateInvoice,
                   content: {
                NavigationStack {
                    CreateInvoiceView()
                }
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Ny Kunde") {
                        showCreateCustomer.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .bold()
                    .font(.title2)
                    .padding(8)
                }
            }
            .safeAreaInset(edge: .bottom,
                           alignment: .leading) {
                Button(action: {
                    showCreateInvoice.toggle()
                }, label: {
                    Label("Ny Faktura", systemImage: "plus")
                        .bold()
                        .font(.title2)
                        .padding(8)
                        .background(.blue.opacity(0.1),
                                    in: Capsule())
                        .padding(.leading)
                        .symbolVariant(.circle.fill)
                })
            }
        }
    }
    
    private func delete(item: Invoice) {
        withAnimation {
            modelContext.delete(item)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Invoice.self, inMemory: true)
}

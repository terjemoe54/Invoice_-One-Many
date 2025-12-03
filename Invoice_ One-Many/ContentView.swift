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
    @Query private var paytos: [PayTo]
    @State private var payto: String = ""
    
    var body: some View {
        List {
            Section("PayTo Title") {
                TextField("Enter PayTo Here", text: $payto)
                Button("Add PayTo") {
                    context.insert(PayTo(title: payto))
                }
                .disabled(payto.isEmpty)
            }
            
            Section("PayTos") {
                ForEach(paytos) { payto in
                    Text(payto.title)
                }
            }
            
        }
        .navigationTitle("Create ToDo")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

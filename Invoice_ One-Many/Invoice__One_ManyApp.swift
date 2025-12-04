//
//  Invoice__One_ManyApp.swift
//  Invoice_ One-Many
//
//  Created by Terje Moe on 03/12/2025.
//

import SwiftUI
import SwiftData

@main
struct Invoice__One_ManyApp: App {
    var body: some Scene {
        WindowGroup {
            // CreateCustomerView()
            // CreateInvoiceView()
            ContentView()
            .modelContainer(for: [Customer.self, Invoice.self])
         }
    
    }
   
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}

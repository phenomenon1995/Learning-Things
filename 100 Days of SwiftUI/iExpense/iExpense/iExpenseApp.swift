//
//  iExpenseApp.swift
//  iExpense
//
//  Created by David Williams on 8/25/24.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    let container = try! ModelContainer(for: ExpenseItem.self)
    var body: some Scene {
        WindowGroup {
            //TestLoad()
            ContentView()
        }
        .modelContainer(container)

    }
}

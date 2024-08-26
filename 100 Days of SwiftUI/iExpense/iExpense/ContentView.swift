//
//  ContentView.swift
//  iExpense
//
//  Created by David Williams on 8/25/24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    let types = ["Business", "Personal"]
    var items: Array<ExpenseItem> = [ExpenseItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self,from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    @State private var expenses: Expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var textColor: Color = .black
    
    var body: some View{
        NavigationStack{
            List{
                ForEach(expenses.types, id: \.self){type in
                    Section(type){
                        ForEach(expenses.items){item in
                            if item.type == type {
                                HStack {
                                    VStack (alignment: .leading){
                                        Text(item.name)
                                            .font(.headline)
                                        Text(item.type)
                                    }
                                    Spacer()
                                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                }
                                .foregroundStyle(item.amount < 9.99 ? .red :
                                                    item.amount > 99.99 ? .green : .black)
                            }
                        }
                            
                        .onDelete(perform: removeItems(at:))
                    }
                }
                
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button("Add Expense", systemImage: "plus"){
                    showingAddExpense = true
                }
            }
        }
        .sheet(isPresented: $showingAddExpense, content: {
            AddView(expenses: expenses)
        })
    }
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}

//
//  ExpensesView.swift
//  iExpense
//
//  Created by David Williams on 9/5/24.
//

import SwiftData
import SwiftUI


struct ExpensesView: View {
    
    @Query var expenses: [ExpenseItem]
    @Environment(\.modelContext) var modelContext
    @State private var showingAddExpense = false
    @State private var textColor: Color = .black
    
    var body: some View {
        
            List{
                ForEach(ExpenseItem.types, id: \.self){type in
                    Section(type){
                        ForEach(expenses){item in
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
    }
    
    init(filterBy: [String], sortBy: [SortDescriptor<ExpenseItem>]){
        _expenses = Query(filter: #Predicate<ExpenseItem>{item in
            return filterBy.contains(item.type)
        }, sort: sortBy)
    }
    
    func removeItems(at offsets: IndexSet){
        for i in offsets{
            modelContext.delete(expenses[i])
        }
    }
}

#Preview {
    ExpensesView(filterBy: ["Personal", "Business"], sortBy: [SortDescriptor(\ExpenseItem.amount),
                                                              SortDescriptor(\ExpenseItem.type),
                                                              SortDescriptor(\ExpenseItem.name)])
}

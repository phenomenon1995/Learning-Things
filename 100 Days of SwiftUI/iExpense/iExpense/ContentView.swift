//
//  ContentView.swift
//  iExpense
//
//  Created by David Williams on 8/25/24.
//

import SwiftData
import SwiftUI

@Model
class ExpenseItem: Identifiable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    static let types = ["Business", "Personal"]
    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
   
}


struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var sortOrder = [SortDescriptor<ExpenseItem>]()
    @State private var filter = ExpenseItem.types
    var body: some View{
        NavigationStack(){
            ExpensesView(filterBy: filter, sortBy: sortOrder)
                .navigationTitle("iExpense")
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        NavigationLink{
                            AddView()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem(placement: .topBarLeading){
                        Button("Reset"){
                            makeSample()
                            filter = ExpenseItem.types
                        }
                    }
                    ToolbarItem(placement:.secondaryAction){
                        Picker("Sort By", selection: $sortOrder){
                            Text("Name")
                                .tag([
                                    SortDescriptor(\ExpenseItem.name),
                                    SortDescriptor(\ExpenseItem.type),
                                    SortDescriptor(\ExpenseItem.amount)]
                                )
                            Text("Amount")
                                .tag([
                                    SortDescriptor(\ExpenseItem.amount),
                                    SortDescriptor(\ExpenseItem.type),
                                    SortDescriptor(\ExpenseItem.name)]
                                )
                        }
                    }
                    ToolbarItem(placement:.secondaryAction){
                        Picker("Show", selection: $filter){
                            Text("All")
                                .tag(ExpenseItem.types)
                            ForEach(ExpenseItem.types, id: \.self){type in
                                Text(type)
                                    .tag([type])
                            }
                        }
                    }
                }
        }
    }
    
   
        
    
    func makeSample(){
        var tempArray = [ExpenseItem]()
        do{
            try modelContext.delete(model: ExpenseItem.self)
            let item1 = ExpenseItem(name: "Expense 1", type: "Personal", amount: 2.00)
            let item2 = ExpenseItem(name: "Expense 2", type: "Personal", amount: 20.00)
            let item3 = ExpenseItem(name: "Expense 3", type: "Personal", amount: 200.00)
            let item4 = ExpenseItem(name: "Expense 4", type: "Business", amount: 6.00)
            let item5 = ExpenseItem(name: "Expense 5", type: "Business", amount: 60.00)
            let item6 = ExpenseItem(name: "Expense 6", type: "Business", amount: 600.00)
            tempArray.append(item1)
            tempArray.append(item2)
            tempArray.append(item3)
            tempArray.append(item4)
            tempArray.append(item5)
            tempArray.append(item6)
            for expense in tempArray {
                modelContext.insert(expense)
            }
        } catch {
            print("WHOOPS")
        }
        
        
    }
    
    
}

#Preview {
    
    ContentView()
}

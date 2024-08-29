//
//  HapticView.swift
//  CupcakeCorner
//
//  Created by David Williams on 8/29/24.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path){
            Form{
                Section{
                    Picker("Select your cake type", selection: $order.type){
                        ForEach(Order.types.indices, id: \.self){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Section{
                    Toggle("Any Special Requests?", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled{
                        Toggle("Add Extra Frosting", isOn: $order.extraFrosting)
                        Toggle("Add Extra Sprinkles", isOn: $order.addSprinkles)
                    }
                }
                Section{
                    NavigationLink("Delivery Details"){
                        AddressView(order: order, path: path)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}

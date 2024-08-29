//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by David Williams on 8/29/24.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    var path: NavigationPath
    var body: some View {
        
        Form {
            
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip Code", text: $order.zip)
            }
            Section{
                NavigationLink("Check out"){
                    CheckoutView(order: order, path: path)
                }
                Toggle("Remember This Info", isOn: $order.saveInfo)
                
            }
            .disabled(order.hasValidAddress)
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel Order"){
                        
                    }
                }
            }
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    AddressView(order: Order(), path: NavigationPath())
}

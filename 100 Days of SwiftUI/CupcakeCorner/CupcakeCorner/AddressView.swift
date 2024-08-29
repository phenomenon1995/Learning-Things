//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by David Williams on 8/29/24.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    @Binding var path: NavigationPath
    var body: some View {
        
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip Code", text: $order.zip)
            }
            Section{
                Button{
                    path.append("CheckoutView")
                } label: {
                    Text("Checkout")
                }
                .frame(maxWidth: .infinity)
                Toggle("Remember This Info", isOn: $order.saveInfo)
            }
            .disabled(order.hasValidAddress)
            .toolbar{
                Button("Cancel Order"){
                    path = NavigationPath()
                }
            }
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by David Williams on 8/29/24.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation: Bool = false
    @State private var errorMessage = ""
    @State private var showingErrorMessage = false
    var path: NavigationPath
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3){ image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height:233)
                Text("Your total cost is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place Order"){
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank You!", isPresented: $showingConfirmation){
        } message: {
            Text(confirmationMessage)
            Button("OK"){
                print(order.saveInfo)
                order.saveUserDefaults()
               
            }
        }
        .alert("Checkout Failed", isPresented: $showingErrorMessage){
        } message: {
            Text(errorMessage)
            Button{
                print(order.saveInfo)
                order.saveUserDefaults()
                
            } label:{
                Text("OK")
            }
        }
    }
    
    func placeOrder () async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return 
        }
        
        let url = URL(string:"https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on the way!"
            showingConfirmation = true
            
            
        } catch {
            errorMessage = error.localizedDescription
            showingErrorMessage = true
        }
        
        
    }
}
#Preview {
    CheckoutView(order: Order(), path: NavigationPath())
}

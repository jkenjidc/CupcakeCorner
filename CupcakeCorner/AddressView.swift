//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Kenji Dela Cruz on 6/21/24.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Steeet Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)){
                    Text("Check out")
                }
            }
            .disabled(order.hasInvalidAddress)
        }
        .navigationTitle("Delivery Details")
        .onDisappear{
            let userDefaults = UserDefaults.standard
            if let contentData = try? JSONEncoder().encode(order) {
                userDefaults.set(contentData, forKey: "savedOrder")
                print(contentData)
            }
        }
    }
}

#Preview {
    AddressView(order: Order())
}

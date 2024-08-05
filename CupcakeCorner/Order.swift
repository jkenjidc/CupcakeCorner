//
//  Order.swift
//  CupcakeCorner
//
//  Created by Kenji Dela Cruz on 6/21/24.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasInvalidAddress: Bool {
        return name.isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        cost += Decimal(type) / 2
        cost += (extraFrosting ? Decimal(quantity) : 0 )
        cost += (addSprinkles ? Decimal(quantity) / 2 : 0)
        return cost
    }
    
    public init(type: Int = 0, quantity: Int = 3, specialRequestEnabled: Bool = false, extraFrosting: Bool = false, addSprinkles: Bool = false, name: String = "", streetAddress: String = "", city: String = "", zip: String = "") {
        self.type = type
        self.quantity = quantity
        self.specialRequestEnabled = specialRequestEnabled
        self.extraFrosting = extraFrosting
        self.addSprinkles = addSprinkles
        self.name = name
        let defaults = UserDefaults.standard
        if let savedOrder = defaults.object(forKey: "savedOrder") as? Data {
            let decoder = JSONDecoder()
            if let loadedOrder = try? decoder.decode(Order.self, from: savedOrder) {
                self.streetAddress = loadedOrder.streetAddress
                self.city = loadedOrder.city
                self.zip = loadedOrder.zip
            }
        }
    }
}

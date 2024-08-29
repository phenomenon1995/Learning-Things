//
//  Order.swift
//  CupcakeCorner
//
//  Created by David Williams on 8/29/24.
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
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
        
        
    }
    
    static let types = ["Vanilla", "Chocolate", "Strawberry", "Rainbow"]
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
    
    var name: String
    var streetAddress: String
    var city: String
    var zip: String
    var hasValidAddress: Bool {
        
        if (name.trimmingCharacters(in: .whitespaces).isEmpty ||
            streetAddress.trimmingCharacters(in: .whitespaces).isEmpty ||
            city.trimmingCharacters(in: .whitespaces).isEmpty ||
            zip.trimmingCharacters(in: .whitespaces).isEmpty) {
            return true
        } else  {
            saveInfo = false
            return false
        }
    }
    var saveInfo: Bool = false {
        willSet {
            if saveInfo == true {
                saveUserDefaults()
                print(saveInfo)
                return
            }
            if saveInfo == false {
                print(saveInfo)
                clearUserDefaults()
                return
            }
            
        }
    }
    var cost: Decimal {
        var cost = Decimal(quantity*2)
        cost += Decimal(type / 2)
        if extraFrosting {
            cost += Decimal(quantity)
        }
        if addSprinkles{
            cost += Decimal(quantity) / 2
        }
        return cost
    }
    init(){
        self.name = UserDefaults.standard.string(forKey: "name") ?? ""
        self.streetAddress = UserDefaults.standard.string(forKey: "streetAddress") ?? ""
        self.city = UserDefaults.standard.string(forKey: "city") ?? ""
        self.zip = UserDefaults.standard.string(forKey: "zip") ?? ""
        
    }
    func clearUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "streetAddress")
        UserDefaults.standard.removeObject(forKey: "city")
        UserDefaults.standard.removeObject(forKey: "zip")
        print("Cleared Defaults")
    }
    func saveUserDefaults(){
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(streetAddress, forKey: "streetAddress")
        UserDefaults.standard.set(city, forKey: "city")
        UserDefaults.standard.set(zip, forKey: "zip")
        
        print("""
User Defaults:
\(UserDefaults.standard.string(forKey: "name") ?? "not found")
\(UserDefaults.standard.string(forKey: "streetAddress") ?? "not found")
\(UserDefaults.standard.string(forKey: "city") ?? "not found")
\(UserDefaults.standard.string(forKey: "zip") ?? "not found")
""")
    }
}


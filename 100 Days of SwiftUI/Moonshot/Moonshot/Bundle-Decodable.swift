//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by David Williams on 8/26/24.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url (forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle ")
        }
        
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context){
            fatalError("Failed to decode \(file) due to a missing key '\(key.stringValue)' - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context){
            fatalError("Failed to decode \(file) due to a type mismatch - \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) due to a missing '\(type)' value  - \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_){
            fatalError("Failed to decode \(file) because data is appears to be invalid")
        } catch {
            fatalError("Failed to decode \(file) beacuse of \(error.localizedDescription)")
        }
    }
}

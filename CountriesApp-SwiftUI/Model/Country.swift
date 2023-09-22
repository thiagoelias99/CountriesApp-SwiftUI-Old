//
//  Country.swift
//  CountriesApp-SwiftUI
//
//  Created by user241339 on 9/22/23.
//

import Foundation

struct Country: Codable, Identifiable{
    var id: String
    var name: String
    var capital: String
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "capital": capital
        ]
    }
}

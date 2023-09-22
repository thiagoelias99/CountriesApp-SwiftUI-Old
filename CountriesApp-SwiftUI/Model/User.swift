//
//  User.swift
//  CountriesApp-SwiftUI
//
//  Created by user241339 on 9/22/23.
//

import Foundation

struct User: Identifiable, Codable{
    var id: String
    var name: String
    var email: String
    var countries: [Country]
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "email": email,
            "countries": countries.map { $0.toDictionary() }
        ]
    }
}

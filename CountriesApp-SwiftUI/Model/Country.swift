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
    var completeName: String
    var capital: String
    var flag: String
    var cca3: String
    var region: String
    var area: Double
    var population: Double
    var coatOfArms: String
    var lat: Double
    var long: Double

    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "completeName": completeName,
            "capital": capital,
            "flag": flag,
            "cca3": cca3,
            "region": region,
            "area": area,
            "population": population,
            "coatOfArms": coatOfArms,
            "lat": lat,
            "long": long
        ]
    }
}

//
//  CountryApi.swift
//  CountriesApp-SwiftUI
//
//  Created by user241339 on 9/22/23.
//

import Foundation

struct CountryApi: Codable, Hashable {
    var name: CountryNameApi
    var flags: Flags
    var capital: [String]
    var cca3: String
    var subregion: String
    var area: Double
    var coatOfArms: Flags
    var population: Double
    var capitalInfo: CapitalInfo
    
    // Implemente o protocolo Hashable manualmente
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    func toCountry() -> Country{
        return Country(
            id: UUID().uuidString,
            name: name.common,
            completeName: name.official,
            capital: capital[0],
            flag: flags.png,
            cca3: cca3,
            region: subregion,
            area: area,
            population: population,
            coatOfArms: coatOfArms.png,
            lat: capitalInfo.latlng[0],
            long: capitalInfo.latlng[1]
        )
    }
}

struct CountryNameApi: Codable, Hashable {
    var common: String
    var official: String
}

struct Flags: Codable, Hashable{
    var png: String
}

struct CapitalInfo: Codable, Hashable {
    var latlng: [Double]
}



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
    
    // Implemente o protocolo Hashable manualmente
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    func toCountry() -> Country{
        return Country(id: UUID().uuidString, name: name.common, capital: name.common, flag: flags.png)
    }
}

struct CountryNameApi: Codable, Hashable {
    var common: String
}

struct Flags: Codable, Hashable{
    var png: String
}


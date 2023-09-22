//
//  CountryApi.swift
//  CountriesApp-SwiftUI
//
//  Created by user241339 on 9/22/23.
//

import Foundation

struct CountryApi: Codable{
    var name: CountryNameApi
}

struct CountryNameApi: Codable{
    var common: String
}

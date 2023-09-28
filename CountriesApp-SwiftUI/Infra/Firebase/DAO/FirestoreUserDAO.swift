//
//  FirestoreUserDAO.swift
//  CountriesApp-SwiftUI
//
//  Created by user241339 on 9/22/23.
//

import Foundation
import Firebase

struct FirestoreUserDAO{
    
    func documentToUser(document: QueryDocumentSnapshot) -> User? {
        var data = document.data()
        
        if let name = data["name"] as? String,
           let email = data["email"] as? String
        {
            var user = User(
                id: document.documentID,
                name: name,
                email: email
            )
            
            if let countries = data["countries"] as? [[String: Any]] {
                for country in countries {
                    if let id = country["id"] as? String,
                       let name = country["name"] as? String,
                       let completeName = country["completeName"] as? String,
                        let capital = country["capital"] as? String,
                        let flag = country["flag"] as? String,
                        let cca3 = country["cca3"] as? String,
                        let region = country["region"] as? String,
                        let area = country["area"] as? Double,
                        let population = country["population"] as? Double,
                        let coatOfArms = country["coatOfArms"] as? String,
                        let lat = country["lat"] as? Double,
                        let long = country["long"] as? Double
                        
                    {
                        user.countries.append(Country(
                            id: id,
                            name: name,
                            completeName: completeName,
                            capital: capital,
                            flag: flag,
                            cca3: cca3,
                            region: region,
                            area: area,
                            population: population,
                            coatOfArms: coatOfArms,
                            lat: lat,
                            long: long
                        ))
                    }
                }
            }
            
            return user
        } else {
            print("Deu ruim :/")
            return nil
        }
    }
}

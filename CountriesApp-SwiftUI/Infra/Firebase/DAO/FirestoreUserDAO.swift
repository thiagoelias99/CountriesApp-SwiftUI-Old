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
                       let capital = country["capital"] as? String
                    {
                        user.countries.append(Country(id: id, name: name, capital: capital))
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

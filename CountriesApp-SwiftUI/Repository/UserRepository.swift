//
//  UserRepository.swift
//  CountriesApp-SwiftUI
//
//  Created by user241339 on 9/22/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


struct UserRepository{
    let db = Firestore.firestore()
    
    func createUser(name: String, email: String) -> String{
        var user = User(id: UUID().uuidString, name: name, email: email)
        
        let docRef = db.collection("users").document(user.id)
        
        docRef.setData(user.toDictionary()) { err in
            if let err = err {
                print("Error setting document: \(err)")
            }
        }
        return user.id
    }
    
    func updateUser(user: User){
        let docRef = db.collection("users").document(user.id)
        
        docRef.setData(user.toDictionary()) { err in
            if let err = err {
                print("Error setting document: \(err)")
            }
        }
    }
    
    func getUserByEmail(email: String) async -> User? {
        let collectionRef = db.collection("users")
        
        do {
            let querySnapshot = try await collectionRef.whereField("email", isEqualTo: email).getDocuments()
            
            if querySnapshot.documents.isEmpty {
                return nil // Não encontrou um usuário com o email fornecido
            }
            
            if let userDocument = querySnapshot.documents.first {
                return FirestoreUserDAO().documentToUser(document: userDocument)
            }
        } catch {
            print("Erro ao consultar o Firestore: \(error)")
        }
        
        return nil // Retorna nil em caso de erro ou se não encontrou um usuário
    }

}

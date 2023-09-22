//
//  ContentView.swift
//  CountriesApp-SwiftUI
//
//  Created by Thiago Elias on 9/17/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Alamofire

struct ContentView: View {
    @State private var showLoginScreen = Auth.auth().currentUser?.email == nil
    
    let apiUrl = "https://restcountries.com/v3.1/name/br"
    let db = Firestore.firestore()
    
    @State private var countries: [CountryApi] = []
    
    init(){
       // getUserInfos()
        getCountry()
        searchFirestoreForEmail()
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button(action: {
                do {
                    try Auth.auth().signOut()
                    showLoginScreen = true
                } catch let signOutError as NSError {
                    print("Error signing out: %@", signOutError)
                }
            }) {
                Text("Logout")
            }
            .padding(.trailing, 8)
        }
        .padding()
        .fullScreenCover(isPresented: $showLoginScreen){
            LoginView()
        }
    }
    
    func getCountry(){
        AF.request(apiUrl)
            .validate()
            .responseDecodable(of: [CountryApi].self){ response in
                switch response.result {
                case .success(let countries):
                    self.countries = countries
                    
                    for country in countries{
                        print(country.name.common)
                    }
                case .failure(let error):
                    print("Erro ao obter países :/ : \(error)")
                }
            }
    }
    
    func getUserInfos(){

        var countries: [Country] = []
        
        var country = Country(id: "BRA", name: "Brazil", capital: "Brasília")
        
        countries.append(country)
        
        var user = User(id: UUID().uuidString, name: "Thiago", email: "thiago@email.com", countries: countries)

        let docRef = db.collection("users").document(user.id)
        
        docRef.setData(user.toDictionary()) { err in
            if let err = err {
                print("Error setting document: \(err)")
            } else {
                print("Document set with ID: \(docRef.documentID)")
            }
        }
    }
    
    func searchFirestoreForEmail() {
        let userEmail = Auth.auth().currentUser?.email ?? ""
        let collectionRef = db.collection("users")

        collectionRef.whereField("email", isEqualTo: userEmail).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            guard let userDocument = querySnapshot?.documents[0] else {
                return
            }
            
            guard let user = FirestoreUserDAO().documentToUser(document: userDocument) else{
                return
            }
            print(user.name)
            print(user.countries)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

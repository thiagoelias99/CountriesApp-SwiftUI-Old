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
    @State var showLoginScreen = Auth.auth().currentUser?.email == nil
    let apiUrl = "https://restcountries.com/v3.1/name/br"
    let userEmail = Auth.auth().currentUser?.email ?? ""
    let db = Firestore.firestore()
    var user: User? = nil
    @State private var countries: [CountryApi] = []

    init() {
        // Não execute tarefas assíncronas no construtor, mova para onAppear
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
        .fullScreenCover(isPresented: $showLoginScreen) {
            LoginView()
        }
        .onAppear {
            // Execute a lógica assíncrona aqui usando uma função assíncrona
            async {
                print(userEmail)
                var localSelf = self // Cria uma cópia local de self
                localSelf.user = await UserRepository().getUserByEmail(email: localSelf.userEmail)
                print(localSelf.user)
                if localSelf.user == nil {
                    localSelf.showLoginScreen = true
                } else {
                    print("Logged user \(localSelf.user?.name) - \(localSelf.user?.email)")
                }
            }
        }
    }

    func getCountry() {
        AF.request(apiUrl)
            .validate()
            .responseDecodable(of: [CountryApi].self) { [self] response in // Use [self] para capturar self de forma segura
                switch response.result {
                case .success(let countries):
                    self.countries = countries

                    for country in countries {
                        print(country.name.common)
                    }
                case .failure(let error):
                    print("Erro ao obter países :/ : \(error)")
                }
            }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

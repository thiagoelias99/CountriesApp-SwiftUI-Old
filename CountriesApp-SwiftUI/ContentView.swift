//
//  ContentView.swift
//  CountriesApp-SwiftUI
//
//  Created by Thiago Elias on 9/17/23.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var showLoginScreen = Auth.auth().currentUser?.email == nil
        
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

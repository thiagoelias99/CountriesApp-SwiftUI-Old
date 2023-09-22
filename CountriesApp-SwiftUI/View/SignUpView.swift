//
//  SignUpView.swift
//  CountriesApp-SwiftUI
//
//  Created by user241339 on 9/21/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @State private var mostrarSenha = false
    @State private var lembrarSenha = false
    @State private var nameInput = ""
    @State private var emailInput = ""
    @State private var passwordInput = ""
    @State private var passwordConfirmInput = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var showLoginScreen = false
    
    private var mainColorDark: UInt32 = 0x463E30
    private var mainColorLight: UInt32 = 0x6B5E4B
    let db = Firestore.firestore()
    

    
    //    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .center){
                Image("BannerLogin")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .scaleEffect(1.5)
                    .padding(.bottom, 20)
                
                VStack{
                    VStack(alignment: .leading){
                        Text("Crie sua conta")
                            .foregroundColor(Color(hex: mainColorDark))
                            .font(.title)
                            .bold()
                        
                        Group{
                            Text("Seu nome")
                                .foregroundColor(Color(hex: mainColorDark))
                                .font(.body)
                                .padding(.top, 4)
                                .bold()
                            TextField("", text: $nameInput)
                                .font(.body)
                                .border(Color(hex: mainColorDark))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Text("Seu email")
                                .foregroundColor(Color(hex: mainColorDark))
                                .font(.body)
                                .padding(.top, 4)
                                .bold()
                            TextField("", text: $emailInput)
                                .font(.body)
                                .border(Color(hex: mainColorDark))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                            
                            Text("Digite uma senha")
                                .foregroundColor(Color(hex: mainColorDark))
                                .font(.body)
                                .padding(.top, 4)
                                .bold()
                            SecureField ("", text: $passwordInput)
                                .font(.body)
                                .border(Color(hex: mainColorDark))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                                .textContentType(.password)
                            
                            Text("Repita a senha")
                                .foregroundColor(Color(hex: mainColorDark))
                                .font(.body)
                                .padding(.top, 4)
                                .bold()
                            SecureField ("", text: $passwordConfirmInput)
                                .font(.body)
                                .border(Color(hex: mainColorDark))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                                .textContentType(.password)
                        }
                        
                        Button(action: {
                            signUp(
                                userName: nameInput,
                                email: emailInput,
                                password: passwordInput,
                                passwordCheck: passwordConfirmInput
                            )
                        }){
                            Text("Criar conta")
                                .font(.body)
                                .foregroundColor(.white)
                            
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Color(hex: mainColorDark))
                        .cornerRadius(10)
                        .padding(.top)
                        
                        HStack{
                            Text("Já possui uma conta?")
                                .foregroundColor(.gray)
                            Button {
                                showLoginScreen = true
                            } label: {
                                Text("Entre")
                                    .foregroundColor(Color(hex: mainColorDark))
                                    .bold()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top)
                        
                    }
                    .padding(.horizontal, 20.0)
                    .padding(.vertical, 20.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                }
                .padding(.horizontal)
                
                HStack{
                    Text("Desenvolvido por")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.trailing, 0)
                    Text("Thiago Elias")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.leading, 0)
                }
                .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(hex: mainColorLight), Color(hex: mainColorLight), Color(hex: mainColorDark)]), startPoint: .top, endPoint: .bottom)
            )
            .edgesIgnoringSafeArea(.all)
            .fullScreenCover(isPresented: $showLoginScreen){
                LoginView()
            }
            .alert(isPresented: $showAlert){
                Alert(title: Text("Falha no cadastro"), message: Text(alertMessage))
            }
        }
    }
    func signUp(userName: String, email: String, password: String, passwordCheck: String){
        
        if(password != passwordCheck){
            print("As senha não são iguais")
            alertMessage = "As senha não são iguais"
            showAlert = true
            return
        }
        if(userName.isEmpty || email.isEmpty || password.isEmpty || passwordCheck.isEmpty){
            print("Todos os campos devem ser preeenchidos")
            alertMessage = "Todos os campos devem ser preeenchidos"
            showAlert = true
            return
        }
        Auth.auth().createUser(withEmail: email, password: password){ authResult, error in
            
            guard let _ = authResult else {
                print(error?.localizedDescription ?? "Ocorreu um erro do Firebase")
                alertMessage = error?.localizedDescription ?? "Ocorreu um erro do Firebase"
                showAlert = true
                return
            }
            
            createUser()

            showLoginScreen = true
        }
    }
    
    private func createUser(){
        var user = User(id: UUID().uuidString, name: nameInput, email: emailInput)
        
        let docRef = db.collection("users").document(user.id)
        
        docRef.setData(user.toDictionary()) { err in
            if let err = err {
                print("Error setting document: \(err)")
            } else {
                print("Document set with ID: \(docRef.documentID)")
            }
        }
    }
    
}






struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

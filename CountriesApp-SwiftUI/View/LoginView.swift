//
//  LoginView.swift
//  CountriesApp-SwiftUI
//
//  Created by Thiago Elias on 9/19/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var showPassword = false
    @State private var rememberUser = false
    @State private var emailInput = ""
    @State private var passwordInput = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var showSignUpScreen = false
    @State private var showMainScreen = false
    
    private var mainColorDark: UInt32 = 0x463E30
    private var mainColorLight: UInt32 = 0x6B5E4B    
    
    var body: some View {
        VStack(alignment: .center){
            Image("BannerLogin")
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .scaleEffect(1.5)
                .padding(.bottom, 20)
            
            VStack{
                VStack(alignment: .leading){
                    Text("Entre com sua conta")
                        .foregroundColor(Color(hex: mainColorDark))
                        .font(.title)
                        .bold()
                    Text("Email")
                        .foregroundColor(Color(hex: mainColorDark))
                        .font(.body)
                        .padding(.top, 4)
                        .bold()
                    TextField("", text: $emailInput)
                        .font(.body)
                        .border(Color(hex: mainColorDark))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                    HStack{
                        Text("Senha")
                            .foregroundColor(Color(hex: mainColorDark))
                            .font(.body)
                            .bold()
                        Spacer()
                        Text("Recuperar Senha")
                            .foregroundColor(Color(hex: mainColorDark))
                            .font(.body)
                            .bold()
                            .foregroundColor(Color(hex: mainColorDark))
                    }
                    .padding(.top, 4)
                    ZStack(alignment: .trailing) {
                        Group {
                            if showPassword {
                                TextField("", text: $passwordInput)
                                    .font(.body)
                                    .border(Color(hex: mainColorDark))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .autocapitalization(.none)
                                    .textContentType(.password)
                            } else {
                                SecureField("", text: $passwordInput)
                                    .font(.body)
                                    .border(Color(hex: mainColorDark))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .autocapitalization(.none)
                                    .textContentType(.password)
                            }
                        }
                        
                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(systemName: self.showPassword ? "eye.slash" : "eye")
                                .accentColor(.gray)
                        }
                        .padding(.trailing, 8)
                    }
                    
                    HStack(alignment: .center){
                        Spacer()
                        Text("Lembrar me")
                            .font(.caption)
                        Toggle("", isOn: $rememberUser)
                            .tint(Color(hex: mainColorDark))
                            .frame(width: 50)
                    }
                    Button(action: {
                        login()
                    }){
                        Text("Entrar")
                            .font(.body)
                            .foregroundColor(.white)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color(hex: mainColorDark))
                    .cornerRadius(10)
                    .padding(.top)
                    
                    Button(action: {}){
                        HStack{
                            Image(systemName: "apple.logo")
                                .tint(.white)
                            Text("Continuar com Apple")
                                .font(.body)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(.black)
                    .cornerRadius(10)
                    
                    HStack{
                        Text("Não possui uma conta?")
                            .foregroundColor(.gray)
                        Button {
                            showSignUpScreen = true
                        } label: {
                            Text("Cadastre")
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
        .fullScreenCover(isPresented: $showSignUpScreen){
            SignUpView()
        }
        .fullScreenCover(isPresented: $showMainScreen){
            ContentView()
        }
        .alert(isPresented: $showAlert){
            Alert(title: Text("Falha no login"), message: Text(alertMessage))
        }
    }
    
    //Login/ validação com firebase auth
    func login(){
        if(passwordInput.isEmpty || emailInput.isEmpty ){
            print("Todos os campos devem ser preeenchidos")
            alertMessage = "Todos os campos devem ser preeenchidos"
            showAlert = true
            return
        }
        
        Auth.auth().signIn(withEmail: emailInput, password: passwordInput){
            authResult, error in
            
            guard let user = authResult else {
                print(error?.localizedDescription ?? "Ocorreu um erro do Firebase")
                alertMessage = error?.localizedDescription ?? "Ocorreu um erro do Firebase"
                showAlert = true
                return
            }
            
            print(Auth.auth().currentUser?.email ?? "")
            showMainScreen = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

//
//  SignUpView.swift
//  CountriesApp-SwiftUI
//
//  Created by user241339 on 9/21/23.
//

import SwiftUI

struct SignUpView: View {
    @State private var mostrarSenha = false
    @State private var lembrarSenha = false
    @State private var nameInput = ""
    @State private var emailInput = ""
    @State private var passwordInput = ""
    @State private var passwordConfirmInput = ""
    
    @State private var showLoginScreen = false
    
    private var mainColorDark: UInt32 = 0x463E30
    private var mainColorLight: UInt32 = 0x6B5E4B
    
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
                                .autocapitalization(.none)
                            
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
                            TextField("", text: $passwordInput)
                                .font(.body)
                                .border(Color(hex: mainColorDark))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                            
                            Text("Repita a senha")
                                .foregroundColor(Color(hex: mainColorDark))
                                .font(.body)
                                .padding(.top, 4)
                                .bold()
                            TextField("", text: $passwordConfirmInput)
                                .font(.body)
                                .border(Color(hex: mainColorDark))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                        }
                        
                        Button(action: {}){
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
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

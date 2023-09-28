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
import URLImage

struct ContentView: View {
    //@State var showLoginScreen = Auth.auth().currentUser?.email == nil
    
    @State var showLoginScreen = false
    @State var showDetailsScreen = false
    @State var selectedCountry: Country = Country(
        id: "",
        name: "Brazil",
        completeName: "Federative Republic of Brazil",
        capital: "Brasília",
        flag: "https://flagcdn.com/w320/br.png",
        cca3: "BRA",
        region: "South America",
        area: 8515767.00,
        population: 212559409.00,
        coatOfArms: "https://mainfacts.com/media/images/coats_of_arms/br.png",
        lat: -15.79,
        long: -47.88
    )
    
    
    let apiUrl = "https://restcountries.com/v3.1/name/"
    let userEmail = Auth.auth().currentUser?.email ?? ""
    let db = Firestore.firestore()
    @State private var user: User? = nil
    @State private var countries: [CountryApi] = []
    
    private var buttonColor: UInt32 = 0xdbc59e
    private var cardBackGround: UInt32 = 0xffffff
    private var cardForeGround: UInt32 = 0x463e30
    
    @State private var countrySearch: [CountryApi] = []
    
    @State private var countryInput = ""
    
    @State private var apresentarFolha = false
    
    init() {
        
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack{
                Text("Olá, \(user?.name ?? "")")
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                Spacer()
                Button(action: {
                    logout()
                }){
                    Image(systemName: "return.right")
                        .foregroundColor(.white)
                }
            }
            
            VStack(alignment: .leading){
                Text("Minha lista de países")
                    .foregroundColor(.white)
                    .font(.body)
                    .padding(.top, 4)
                    .bold()
                
                ForEach(user?.countries ?? []) { country in
                    HStack{
                        if let url = URL(string: country.flag ?? ""){
                            URLImage(url){ image in
                                image
                                    .resizable()
                                    .foregroundColor(Color(hex: cardForeGround))
                                    .frame(width: 75, height: 55)
                                    .padding(10)
                            }
                        }
                        
                        Text(country.name)
                            .foregroundColor(Color(hex: cardForeGround))
                            .font(.body)
                            .padding(.top, 4)
                            .bold()
                        Spacer()
                    }
                    .background(Color(hex: cardBackGround))
                    .onTapGesture {
print(country)
                        selectedCountry = country
                        globalSelectedCountry = country
                        print(selectedCountry)
                        showDetailsScreen = true

                    }
                    
                }
                
                Spacer()
                
                Button(action: {
                    apresentarFolha = true
                }){
                    Text("Adicionar País")
                        .font(.body)
                        .foregroundColor(.black)
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(Color(hex: buttonColor))
                .cornerRadius(10)
                .padding(.top)
            }
            VStack{
                Image("FooterLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .scaleEffect(1.5)
                
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
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .fullScreenCover(isPresented: $showLoginScreen) {
            LoginView()
        }
        .fullScreenCover(isPresented: $showDetailsScreen){
                CountryDetailsView(country: selectedCountry)
        }
        .onAppear {
            // Execute a lógica assíncrona aqui usando uma função assíncrona
            async {
                print(userEmail)
                var localSelf = self // Cria uma cópia local de self
                localSelf.user = await UserRepository().getUserByEmail(email: localSelf.userEmail)
                print(localSelf.user)
                if localSelf.user == nil {
                    // localSelf.showLoginScreen = true
                } else {
                    print("Logged user \(localSelf.user?.name) - \(localSelf.user?.email)")
                }
            }
        }
        .background(Color(hex: 0x443e32))
        .sheet(isPresented: $apresentarFolha) {
            VStack{
                Text("Digite o nome do país")
                    .foregroundColor(.white)
                    .font(.body)
                    .padding(10)
                    .bold()
                TextField("", text: $countryInput)
                    .font(.body)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .onChange(of: countryInput){ newText in
                        getCountry(text: newText)
                    }
                ForEach(countrySearch ?? [], id: \.self) { (country: CountryApi) in
                    HStack {
                        if let url = URL(string: country.flags.png ?? ""){
                            URLImage(url){ image in
                                image
                                    .resizable()
                                    .foregroundColor(Color(hex: cardForeGround))
                                    .frame(width: 75, height: 55)
                                    .padding(10)
                            }
                        }
                        Text(String(describing: country.name.common))
                            .foregroundColor(Color(hex: cardForeGround))
                            .font(.body)
                            .padding(.top, 4)
                            .bold()
                        
                        Spacer()
                    }
                    .background(Color(hex: cardBackGround))
                    .onTapGesture {
                        user?.countries.append(country.toCountry())
                        UserRepository().updateUser(user: user!)
                        apresentarFolha = false
                    }
                }
                .padding(10)

                Spacer()
            }
            .padding(10)
            .background(Color(hex: 0x443e32))
        }
    }
    
    func getCountry(text: String) {
        AF.request(apiUrl + text)
            .validate()
            .responseDecodable(of: [CountryApi].self) { [self] response in // Use [self] para capturar self de forma segura
                switch response.result {
                case .success(let countries):
                    self.countries = countries
                    countrySearch = countries
                    
                case .failure(let error):
                    print("Erro ao obter países :/ : \(error)")
                }
            }
    }
    
    func logout(){
        user = nil
        showLoginScreen = true
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

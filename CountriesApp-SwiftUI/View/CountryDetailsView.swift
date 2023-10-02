//
//  CountryDetailsView.swift
//  CountriesApp-SwiftUI
//
//  Created by user241339 on 9/28/23.
//

import SwiftUI
import URLImage

struct CountryDetailsView: View {
    
    let country: Country
    
    var textColor: UInt32 = 0xDBC59E
    
    @State var showMainScreen = false

    var body: some View {
        VStack{
            HStack{
                Text("Voltar")
                    .onTapGesture {
                        showMainScreen = true
                    }
                Spacer()
            }
            .padding(10)
            
            if let country2 = globalSelectedCountry{
                TabView{
                    CountryInfosView(country: country2)
                        .tabItem(){
                            Group{
                                Image(systemName: "info.circle")
                                    .foregroundColor(.white)
                                Text("Infos")
                                    .foregroundColor(.white)
                            }
                        }
                    CountryMapView(latitude: country2.lat, longitude: country2.long)
                        .tabItem(){
                            Group{
                                Image(systemName: "map.circle.fill")
                                    .foregroundColor(.white)
                                Text("Localização")
                                    .foregroundColor(.white)
                            }
                        }
                }
                .onAppear(){
                    UITabBar.appearance().backgroundColor = .black
                }
                .tint(.white)
            }
        }
        .fullScreenCover(isPresented: $showMainScreen){
            ContentView()
        }
    }
}

struct CountryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailsView(
            country: Country(
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
            ))
    }
}

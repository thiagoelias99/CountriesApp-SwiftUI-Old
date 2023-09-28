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

    var body: some View {
        if let country2 = globalSelectedCountry{
            VStack(alignment: .leading){
                
                HStack{
                    Spacer()
                    if let url = URL(string: country2.flag ?? ""){
                        URLImage(url){ image in
                            image
                                .resizable()
                                .frame(width: .infinity, height: 200)
                        }
                        Spacer()
                    }
                }
                Group{
                    Text(country2.name ?? "")
                        .font(.title)
                        .bold()
                        .padding(.top, 10)
                    Text(country2.completeName ?? "")
                        .font(.subheadline)
                        .bold()
                }
                .foregroundColor(Color(hex: textColor))
                Group{
                    Text("Capital")
                        .font(.title2)
                        .bold()
                        .padding(.top, 10)
                    Text(country2.capital ?? "")
                        .font(.body)
                }
                .foregroundColor(Color(hex: textColor))
                Group{
                    Text("Region")
                        .font(.title2)
                        .bold()
                        .padding(.top, 10)
                    Text(country2.region ?? "")
                        .font(.body)
                }
                .foregroundColor(Color(hex: textColor))
                HStack{
                    if let url = URL(string: country2.coatOfArms ?? ""){
                        Spacer()
                        URLImage(url){ image in
                            image
                                .resizable()
                                .frame(width: 200, height: 200)
                        }
                        Spacer()
                    }
                }
                .padding(.top, 30)
                Spacer()
            }
            .padding(.all)
            .background(Color(hex: 0x443e32))
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

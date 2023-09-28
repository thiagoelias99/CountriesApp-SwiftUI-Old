//
//  CountryListItem.swift
//  CountriesApp-SwiftUI
//
//  Created by user241339 on 9/28/23.
//

import SwiftUI
import URLImage

struct CountryListItem: View {
    var country: Country
    
    var cardBackGround: UInt32 = 0xffffff
    var cardForeGround: UInt32 = 0x463e30
    
    let imageURLString = "https://flagcdn.com/w320/br.png"
    
    var body: some View {
        HStack{
            URLImage(URL(string: imageURLString)!) { image in
                image
                    .resizable()
                    .frame(width: 75, height: 55)
                    .padding(10)
            }
            Text(country.name)
                .foregroundColor(Color(hex: cardForeGround))
                .font(.body)
                .padding(.top, 4)
                .bold()
            Spacer()
        }
        .background(Color(hex: cardBackGround))
    }
}

struct CountryListItem_Previews: PreviewProvider {
    static var previews: some View {
        CountryListItem(
            country: Country(id: "asd", name: "Brazil", capital: "Brasilia")
        )
    }
}

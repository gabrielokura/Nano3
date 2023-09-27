//
//  ClothingCardView.swift
//  MyCollection
//
//  Created by Gabriel Motelevicz Okura on 27/09/23.
//

import SwiftUI

struct ClothingListView: View {
    let clothes: [ClothingModel]
    
    var body: some View {
        VStack {
            ForEach(clothes, id: \.self) { clothing in
                ClothingCardView(clothing: clothing)
            }
        }
    }
}

struct ClothingCardView: View {
    let clothing: ClothingModel
    
    var body: some View {
        HStack {
            Image(systemName: "add")
            
            VStack {
                Text(clothing.name)
                Text(clothing.color)
            }
        }
    }
}

#Preview {
    ClothingListView(clothes: [ClothingModel(name: "Camiseta", color: "Vermelha")])
}

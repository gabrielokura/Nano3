//
//  ClothingCardView.swift
//  MyCollection
//
//  Created by Gabriel Motelevicz Okura on 27/09/23.
//

import SwiftUI

struct ClothingListView: View {
    let clothes: [ClothingModel]
    
    let selectCallback: (String) -> Void
    let deleteCallback: (String) -> Void
    
    var body: some View {
        Grid {
            ForEach(clothes, id: \.self) { clothing in
                ClothingCardView(clothing: clothing, isSelected: true)
                    .contextMenu {
                        VStack {
                            Button() {
                                selectCallback(clothing.name)
                            } label: {
                                HStack {
                                    Text("Selecionar")
                                    Spacer()
                                    Image(systemName: "checkmark")
                                }
                            }
                            
                            Button(role: .destructive) {
                                deleteCallback(clothing.name)
                            } label: {
                                HStack {
                                    Text("Apagar")
                                    Spacer()
                                    Image(systemName: "trash")
                                }
                            }
                            
                        }
                    }
            }
            
            Spacer()
        }
        .padding(20)
    }
}

struct ClothingCardView: View {
    let clothing: ClothingModel
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 20) {
            Image(uiImage: clothing.image.image!)
                .resizable()
                .imageScale(.medium)
                .frame(width: 50, height: 50)

            Text(clothing.name)
                .font(.headline)
            
            Spacer()
        }
        .padding()
        .background {
            Rectangle()
                .fill(.gray.opacity(0.2))
                .cornerRadius(15)
        }
    }
}

#Preview {
    ClothingListView(clothes: [ClothingModel(name: "Camiseta", image: UIImage(systemName: "plus")!.data!)], selectCallback: {_ in }, deleteCallback: {_ in })
        .preferredColorScheme(.dark)
}

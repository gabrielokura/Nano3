//
//  DresserView.swift
//  MyCollection
//
//  Created by Gabriel Motelevicz Okura on 27/09/23.
//

import SwiftUI

struct DresserView: View {
    
    var body: some View {
        Form {
            Section {
                NavigationLink {
                    CollectionView(type: .superiores)
                } label: {
                    DressSelectionButton(title: "Superiores", selectedDress: "Camiseta Vermelha")
                }
                
                NavigationLink {
                    CollectionView(type: .inferiores)
                } label: {
                    DressSelectionButton(title: "Inferiores", selectedDress: nil)
                }
            } header: {
                Text("Peças de roupas atuais")
                    .textCase(.uppercase)
            }
            
        }
        .navigationTitle("Guarda roupa")
    }
}

#Preview {
    NavigationStack {
        DresserView()
            .preferredColorScheme(.dark)
    }
}

struct DressSelectionButton: View {
    let title: String
    let selectedDress: String?
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.white)
                .font(.subheadline)
            
            Spacer()
            
            if selectedDress != nil {
                Text(selectedDress!)
                    .foregroundStyle(.gray)
                    .font(.subheadline)
            }
        }
    }
}

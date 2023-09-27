//
//  CollectionView.swift
//  MyCollection
//
//  Created by Gabriel Motelevicz Okura on 27/09/23.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var viewModel: CollectionViewModel
    var type: ClothingType
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .padding(20)
            case .loaded(let clothes):
                ClothingListView(clothes: clothes)
            }
            
        }
        .navigationTitle("Collection of clothes")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadClothes(off: type)
        }
    }
}

#Preview {
    NavigationStack {
        CollectionView(type: .superiores)
            .environmentObject(CollectionViewModel())
            .preferredColorScheme(.dark)
    }
}

//
//  CollectionView.swift
//  MyCollection
//
//  Created by Gabriel Motelevicz Okura on 27/09/23.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var viewModel: CollectionViewModel
    @EnvironmentObject var dresserViewModel: DresserViewModel
    
    var type: ClothingType
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .padding(20)
            case .loaded(let clothes):
                ClothingListView(
                    clothes: clothes,
                    selectCallback: { name in
                        dresserViewModel.saveUserClothing(name, type: type)
                        dismiss()
                    }) { name in
//                        dresserViewModel.deleteUserClothing(name)
                    }
                
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

//
//  DresserView.swift
//  MyCollection
//
//  Created by Gabriel Motelevicz Okura on 27/09/23.
//

import SwiftUI
import PhotosUI

struct DresserView: View {
    
    @State var selectedPhoto: PhotosPickerItem?
    //TODO: habilitar seleção de múltiplas fotos
//    @State var selectedPhotos: PhotosPickerItem]
    @State var selectedImage: UIImage?
    
    @EnvironmentObject private var viewModel: DresserViewModel
    @EnvironmentObject private var collectionViewModel: CollectionViewModel
    
    var body: some View {
        VStack {
            Form {
                Section {
                    NavigationLink {
                        CollectionView(type: .superiores)
                    } label: {
                        DressSelectionButton(title: "Superiores", selectedDress: viewModel.selectedUpperClothing)
                    }
                    
                    NavigationLink {
                        CollectionView(type: .inferiores)
                    } label: {
                        DressSelectionButton(title: "Inferiores", selectedDress: viewModel.selectedDownClothing)
                    }
                } header: {
                    Text("Peças de roupas atuais")
                        .textCase(.uppercase)
                }
                
                if let selectedImage {
                    VStack {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8.0)
                        
                        switch viewModel.state {
                        case .classifying:
                            ProgressView()
                                .padding()
                        case .classified(let classification):
                            Text(classification)
                        }
                    }
                    .animation(.easeIn, value: selectedImage)
                }
            }
            .navigationTitle("Guarda roupa")
            
            if selectedPhoto == nil {
                PhotosPicker(selection: $selectedPhoto, matching: .images) {
                    Text("Add image")
                }
            } else {
                HStack {
                    Button {
                        print("tocou no remover")
                        
                        withAnimation {
                            selectedPhoto = nil
                            selectedImage = nil
                        }
                    } label: {
                        Text("Remover")
                            .foregroundStyle(.red)
                    }
                    
                    Spacer()
                    
                    Button {
                        guard let image = selectedImage else {
                            print("No image selected")
                            return
                        }
                        
                        guard case let .classified(classification) = viewModel.state else {
                            print("No classification found")
                            return
                        }
                        
                        collectionViewModel.addClothesToTheCloset(image: image, classification: classification)
                        
                        withAnimation {
                            selectedPhoto = nil
                            selectedImage = nil
                        }
                        
                    } label: {
                        Text("Adicionar")
                    }
                }
                .padding()
            }
        }
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                guard let image = UIImage(data: data) else {
                    return
                }
                
                selectedImage = image
                viewModel.classifyImage(image)
            }
        }
        .onAppear {
            viewModel.loadUsedClothes()
        }
    }
}

#Preview {
    NavigationStack {
        DresserView()
            .preferredColorScheme(.dark)
            .environmentObject(CollectionViewModel())
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

//
//  CollectionViewModel.swift
//  MyCollection
//
//  Created by Gabriel Motelevicz Okura on 27/09/23.
//

import Foundation
import SwiftUI



class CollectionViewModel: ObservableObject {
    enum State {
        case loading
        case loaded([ClothingModel])
    }
    
    @Published var state: State = .loading
    
    func loadClothes(off type: ClothingType) {
        state = .loading
        
        let savedClothes = loadFromCache()
        
        switch type {
        case .superiores:
            self.state = .loaded(savedClothes.filter({ model in
                return model.isUpper()
            }))
        case .inferiores:
            self.state = .loaded(savedClothes.filter({ model in
                return !model.isUpper()
            }))
        }
        
    }
    
    func addClothesToTheCloset(image: UIImage, classification: String) {
        let clothing = ClothingModel(name: classification, image: image.data!)
        
        var savedClothes = loadFromCache()
        
        if savedClothes.isEmpty {
            saveInCache([clothing])
            return
        }
        
        savedClothes.append(clothing)
        saveInCache(savedClothes)
    }
    
    private func loadFromCache() -> [ClothingModel]{
        guard let savedClothes = UserDefaults.standard.object(forKey: ClothingModel.clothesCacheKey) else {
            print("Nada salvo em cache")
            return []
        }
        
        guard let clothesData = savedClothes as? Data else {
            print("Failed to convert list of any to Data")
            return []
        }
        
        guard let clothes = try? JSONDecoder().decode([ClothingModel].self, from: clothesData) else {
            print("Could not parse to [ClothingModel]")
            return []
        }
        
        return clothes
    }
    
    private func saveInCache(_ clothes: [ClothingModel]) {
        guard let encodedData = try? JSONEncoder().encode(clothes) else {
            print("Failed to encode data. Saving cancelled")
            return
        }
        
        UserDefaults.standard.set(encodedData, forKey: ClothingModel.clothesCacheKey)

    }
}

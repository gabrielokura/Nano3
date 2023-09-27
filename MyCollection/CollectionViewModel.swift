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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            
            if type == .superiores {
                self.state = .loaded([ClothingModel(name: "camiseta", color: "vermelha")])
            } else {
                self.state = .loaded([ClothingModel(name: "calça", color: "azul")])
            }
            
        }
    }
}

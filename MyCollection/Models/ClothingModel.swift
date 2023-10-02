//
//  ClothingModel.swift
//  MyCollection
//
//  Created by Gabriel Motelevicz Okura on 27/09/23.
//

import SwiftUI

enum ClothingType {
    case superiores, inferiores
}

struct ClothingModel: Codable, Hashable {
    let name: String
    let image: Data
    
    static let upperClothesNames = ["Blazer", "Blouse", "Body", "Dress", "Hat", "Hoodie", "Longsleeve", "Polo", "T-Shirt", "Shirt", "Top"]
   
    func isUpper() -> Bool {
        return  ClothingModel.upperClothesNames.contains { current in
            current == name
        }
    }
}

extension ClothingModel {
    static var clothesCacheKey = "clothes_nano3_key"
    static var upperCacheKey = "upper_nano3_key"
    static var downCacheKey = "down_nano3_key"
}

extension UIImage {
    var data: Data? {
        if let data = self.jpegData(compressionQuality: 1.0) {
            return data
        } else {
            return nil
        }
    }
}

extension Data {
    var image: UIImage? {
        if let image = UIImage(data: self) {
            return image
        } else {
            return nil
        }
    }
}

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

struct ClothingModel: Hashable {
    var name: String
    var color: String
//    var image: Image
}

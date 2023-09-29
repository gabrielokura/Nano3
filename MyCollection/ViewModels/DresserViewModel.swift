//
//  DresserViewModel.swift
//  MyCollection
//
//  Created by Gabriel Motelevicz Okura on 29/09/23.
//

import SwiftUI
import CoreML
import Vision

class DresserViewModel: ObservableObject {
    enum State {
        case classifying
        case classified(String)
    }
    
    @Published var state: State = .classifying
    
    @Published var selectedUpperClothing: String = ""
    @Published var selectedDownClothing: String = ""
    
    func classifyImage(_ image: UIImage) {
        self.state = .classifying
        
        do {
            let config = MLModelConfiguration()
            
            let imageClassifierWrapper = try? ClothesClassifier(configuration: config)
            
            guard let imageClassifier = imageClassifierWrapper else {
                print("App failed to create an image classifier model instance")
                return
            }
            
            let imageClassifierModel = imageClassifier.model
            
            guard let imageClassifierVisionModel = try? VNCoreMLModel(for: imageClassifierModel) else {
                print("App failed to create a `VNCoreMLModel` instance.")
                return
            }
            
            let request = VNCoreMLRequest(model: imageClassifierVisionModel, completionHandler: myResultsMethod)
            request.imageCropAndScaleOption = .centerCrop
//            request.usesCPUOnly = true
            
            
            guard let ciImage = CIImage(image: image) else {
                print("App failed to create a `CIImage`")
                return
            }
            
            let handler = VNImageRequestHandler(ciImage: ciImage)
            try handler.perform([request])
        } catch {
            print("Falhou")
        }
    }
    
    func myResultsMethod(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else {
            print("VNRequest produced the wrong result type \(type(of: request.results)).")
            print("Error: \(String(describing: error?.localizedDescription))")
            return
        }
        
        guard let firstPrediction = results.first else {
            print("Predictions is empty")
            return
        }
        
        self.state = .classified(firstPrediction.identifier)
//        for classification in results {
//            print(classification.identifier, classification.confidence)
//        }
    }
    
    func loadUsedClothes() {
        selectedUpperClothing  = UserDefaults.standard.string(forKey: ClothingModel.upperCacheKey) ?? ""
        selectedDownClothing  = UserDefaults.standard.string(forKey: ClothingModel.downCacheKey) ?? ""
    }
    
    func saveUserClothing(_ name: String, type: ClothingType) {
        if type == .superiores {
            UserDefaults.standard.setValue(name, forKey: ClothingModel.upperCacheKey)
            selectedUpperClothing = name
        } else {
            UserDefaults.standard.setValue(name, forKey: ClothingModel.downCacheKey)
            selectedDownClothing = name
        }
    }
}

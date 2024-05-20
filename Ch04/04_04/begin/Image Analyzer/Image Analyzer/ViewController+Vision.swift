//
//  ViewController+Vision.swift
//  Image Analyzer
//
//  Created by Songkyung Min on 5/19/24.
//  Copyright © 2024 Nyisztor, Karoly. All rights reserved.
//

import UIKit
import Vision

extension ViewController {
    var detectionRequest: VNDetectRectanglesRequest {
        let request = VNDetectRectanglesRequest { request, error in
            if let detectError = error {
                debugPrint(detectError)
                return
            } else {
                guard let observations = request.results as? [VNDetectedObjectObservation] else { return }
                print(observations)
            }
        }
        return request
    }
    
    func performVisionRequest(image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: image.cgOrientation, options: [:])
        
        let requests = [detectionRequest]
        
        DispatchQueue.global(qos: .userInitiated).async {            
            do {
                try imageRequestHandler.perform(requests)
            } catch let error as NSError {
                debugPrint(error.localizedDescription.localizedLowercase)
                return
            }
        }
    }
}

//
//  ScanImage.swift
//  CamCalculator
//
//  Created by Prasetya on 21/05/23.
//

import Combine
import SwiftUI
import Vision

protocol ScanImage {
    func call(_ image: UIImage) -> AnyPublisher<String, Error>
}

class ScanImageImpl: ScanImage {
    func call(_ image: UIImage) -> AnyPublisher<String, Error> {
        return Future<String, Error> { promise in
            // Get the CGImage on which to perform requests.
            guard let cgImage = image.cgImage else {
                promise(.failure(TextRecognitionError.invalidImage))
                return
            }
            
            // Create a new image-request handler.
            let requestHandler = VNImageRequestHandler(cgImage: cgImage)
            
            // Create a new request to recognize text.
            let request = VNRecognizeTextRequest { request, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                guard let results = request.results as? [VNRecognizedTextObservation],
                      !results.isEmpty else {
                    promise(.success(""))
                    return
                }
                
                let recognizedText = results.compactMap { result in
                    // Return the string of the top VNRecognizedText instance.
                    return result
                        .topCandidates(1)
                        .first?
                        .string
                        .extractMatchingSubstring(
                            with: supportedMathPattern)
                }
                    .first ?? ""
                
                promise(.success(recognizedText))
            }
            
            do {
                // Perform the text-recognition request.
                try requestHandler.perform([request])
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    enum TextRecognitionError: Error {
        case invalidImage
    }
}

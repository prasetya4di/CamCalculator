//
//  ScanToolbarButton.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import SwiftUI
import Vision

struct ScanToolbarButton: View {
    @State private var scannedText = ""
    @ObservedObject var viewModel: PhotoPickerModel
    
    var body: some View {
        #if false
        ShowCameraScannerButton()
        #elseif false
        ShowPhotoScannerButton(
        	viewModel: viewModel,
            scannedText: $scannedText,
            scanPhoto: scanPhoto
        )
        #else
        ShowDocumentScannerButton(
            scannedText: $scannedText,
            scanPhoto: scanPhoto
        )
        #endif
    }
    
    func scanPhoto(_ image: UIImage) {
        // Get the CGImage on which to perform requests.
        guard let cgImage = image.cgImage else { return }
        
        // Create a new image-request handler.
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        
        // Create a new request to recognize text.
        let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)
        
        do {
            // Perform the text-recognition request.
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
    }
    
    func recognizeTextHandler(request: VNRequest, error: Error?) {
        guard let observations =
                request.results as? [VNRecognizedTextObservation] else {
            return
        }
        scannedText = observations.compactMap { observation in
            // Return the string of the top VNRecognizedText instance.
            return observation
                .topCandidates(1)
                .first?
                .string
                .extractMatchingSubstring(
                    with: supportedMathPattern)
        }
        .first ?? ""
        
        print("Result = \(scannedText)")
    }
}

struct ScanToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        ScanToolbarButton(
        	viewModel: PhotoPickerModel()
        )
    }
}

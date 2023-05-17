//
//  ShowPhotoScanner.swift
//  CamCalculator
//
//  Created by Prasetya on 17/05/23.
//

import SwiftUI
import PhotosUI
import Vision

struct ShowPhotoScannerButton: View {
    @State private var showPhotoScanner = false
    @State private var scannedText = ""
    @ObservedObject var viewModel: PhotoPickerModel
    
    var body: some View {
        PhotosPicker(
            selection: $viewModel.imageSelection,
            matching: .images,
            photoLibrary: .shared()
        ) {
            Text("Add Input")
        }
        .onChange(of: viewModel.imageState) {
            if case let .success(image) = $0 {
                scanPhoto(image)
            }
        }
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
        let recognizedStrings = observations.compactMap { observation in
            // Return the string of the top VNRecognizedText instance.
            return observation.topCandidates(1).first?.string
        }
        
        // Process the recognized strings.
        scannedText = recognizedStrings
            .joined()
            .extractMatchingSubstring(
                with: supportedMathPattern
            ) ?? ""
    }
}

struct ShowPhotoScanner_Previews: PreviewProvider {
    static var previews: some View {
        ShowPhotoScannerButton(
        	viewModel: PhotoPickerModel()
        )
    }
}

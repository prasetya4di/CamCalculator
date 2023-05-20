//
//  ScanToolbarButton.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import SwiftUI
import Vision

struct ScanToolbarButton: View {
    @Binding var scannedText: String
    @ObservedObject var viewModel: PhotoPickerModel
    
    var body: some View {
        #if APP_RED_BUILT_IN_CAMERA
        ShowCameraScannerButton()
        #elseif APP_RED_CAMERA_ROLL || APP_GREEN_CAMERA_ROLL
        ShowPhotoScannerButton(
        	viewModel: viewModel,
            scannedText: $scannedText,
            scanPhoto: scanPhoto
        )
        #elseif APP_GREEN_FILESYSTEM
        ShowDocumentScannerButton(
            scannedText: $scannedText,
            scanPhoto: scanPhoto
        )
        #else
        EmptyView()
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
    }
}

struct ScanToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        ScanToolbarButton(
            scannedText: .constant(""),
        	viewModel: PhotoPickerModel()
        )
    }
}

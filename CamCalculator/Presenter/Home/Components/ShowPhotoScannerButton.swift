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
    @ObservedObject var viewModel: PhotoPickerModel
    @Binding var scannedText: String
    let scanPhoto: (UIImage) -> Void
    
    var body: some View {
        PhotosPicker(
            selection: $viewModel.imageSelection,
            matching: .images,
            photoLibrary: .shared()
        ) {
            AddInputText()
        }
        .onChange(of: viewModel.imageState) {
            if case let .success(image) = $0 {
                scanPhoto(image)
            }
        }
    }
}

struct ShowPhotoScanner_Previews: PreviewProvider {
    static var previews: some View {
        ShowPhotoScannerButton(
        	viewModel: PhotoPickerModel(),
            scannedText: .constant("")
        ) { _ in }
    }
}

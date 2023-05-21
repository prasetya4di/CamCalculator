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
    let scanPhoto: (UIImage) -> Void
    
    var body: some View {
        #if APP_RED_BUILT_IN_CAMERA
        ShowCameraScannerButton(
        	scannedText: $scannedText
        )
        #elseif APP_RED_CAMERA_ROLL || APP_GREEN_CAMERA_ROLL
        ShowPhotoScannerButton(
        	viewModel: viewModel,
            scannedText: $scannedText,
            scanPhoto: scanPhoto
        )
        #elseif APP_GREEN_FILE_SYSTEM
        ShowDocumentScannerButton(
            scannedText: $scannedText,
            scanPhoto: scanPhoto
        )
        #else
        EmptyView()
        #endif
    }
}

struct ScanToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        ScanToolbarButton(
            scannedText: .constant(""),
        	viewModel: PhotoPickerModel()
        ) { _ in }
    }
}

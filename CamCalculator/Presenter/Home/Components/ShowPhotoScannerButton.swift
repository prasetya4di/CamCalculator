//
//  ShowPhotoScanner.swift
//  CamCalculator
//
//  Created by Prasetya on 17/05/23.
//

import SwiftUI
import PhotosUI

struct ShowPhotoScannerButton: View {
    @State private var showPhotoScanner = false
    @ObservedObject var viewModel: PhotoScannerModel
    
    var body: some View {
        PhotosPicker(
            selection: $viewModel.imageSelection,
            matching: .images,
            photoLibrary: .shared()
        ) {
            Text("Add Input")
        }
        .onChange(of: viewModel.imageState) {
            if case .success(_) = $0 {
                showPhotoScanner = true
            }
        }
        .navigationDestination(isPresented: $showPhotoScanner) {
            PhotoScannerView(
                viewModel: viewModel
            )
        }
    }
}

struct ShowPhotoScanner_Previews: PreviewProvider {
    static var previews: some View {
        ShowPhotoScannerButton(
        	viewModel: PhotoScannerModel()
        )
    }
}
